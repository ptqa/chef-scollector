default['scollector']['host'] 		= '127.0.0.1'
default['scollector']['port'] 		= 8070
default['scollector']['bin_path'] 	= "#{node['go']['gobin']}/scollector"
default['scollector']['conf_dir'] 	= '/etc/scollector'
default['scollector']['log_dir'] 	= '/var/log/scollector'
default['scollector']['collectors_dir'] = '/etc/scollector/collectors'
default['scollector']['config_cookbook'] = 'scollector'

tags = Hash.new().compare_by_identity
node.run_list.roles.each do |role|
      tags['role'] = role
end
tags['environment'] = node.chef_environment
default['scollector']['tags'] = tags

default['go']['packages']           	= ['bosun.org/cmd/scollector']
