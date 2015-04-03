default['scollector']['host'] 		= '127.0.0.1'
default['scollector']['port'] 		= 8070
default['scollector']['bin_path'] 	= "#{node['go']['gobin']}/scollector"
default['scollector']['conf_dir'] 	= '/etc/scollector/'
default['scollector']['log_dir'] 	= '/var/log/scollector/'
default['scollector']['collectors_dir'] = '/etc/scollector/collectors'
default['scollector']['config_cookbook'] = 'scollector'
default['scollector']['tags'] 		= {
  'environment' => node.chef_environment,
  'role' => node.run_list.roles.first || 'unknown'
}

default['go']['packages']           	= ['bosun.org/cmd/scollector']
