default['scollector']['release_url'] = 'https://github.com/bosun-monitor/bosun/releases/download'
default['scollector']['version'] = '0.4.0'
default['scollector']['bin_path'] = '/usr/local/bin/scollector'

case node['kernel']['machine']
when 'x86_64'
  default['scollector']['arch'] = 'amd64'
else
  default['scollector']['arch'] = '386'
end
