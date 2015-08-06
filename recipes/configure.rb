#
# Cookbook Name:: bosun
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



# Select the flavour of Linux we're installing for
if not node['scollector']['init_style']

  platform_major_num = node['platform_version'].split('.')[0].to_i

  case
  when node['platform'] === 'centos' && platform_major_num >= 7
    node.default['scollector']['init_style']      = 'systemd'
  else
    node.default['scollector']['init_style']      = 'runit'
  end

end


[
  node['scollector']['conf_dir'],
  node['scollector']['collectors_dir'],
  node['scollector']['log_dir']
].each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

template "#{node['scollector']['conf_dir']}/scollector.toml" do
  mode 0644
  cookbook node['scollector']['config_cookbook']
  source 'scollector.toml.erb'
end





case node['scollector']['init_style']
when 'systemd'

  execute "systemctl_reload" do
    command     "systemctl daemon-reload"
    action      :nothing
  end

  template "/etc/systemd/system/scollector.service" do
    mode 0644
    source 'scollector.systemd.erb'
    notifies    :run,     "execute[systemctl_reload]",  :immediately
    notifies    :restart, "service[scollector]",        :delayed
  end

  service 'scollector' do
    action      [:enable, :start]
    subscribes  :restart, "template[#{node['scollector']['conf_dir']}/scollector.toml]"
  end

when 'runit'

  include_recipe 'runit'

  runit_service 'scollector' do
    cookbook    node['scollector']['config_cookbook']
    restart_on_update true
    subscribes  :restart, "template[#{node['scollector']['conf_dir']}/scollector.toml]"
    action      :enable
  end

else
  log "Unsupported platform"
end
