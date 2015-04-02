default['scollector']['host'] = '127.0.0.1'
default['scollector']['port'] = 8070
default['scollector']['conf_dir'] = '/etc/scollector/'
default['scollector']['collectors_dir'] = '/etc/scollector/collectors'
default['scollector']['bin_path'] = '/usr/local/bin/scollector'
default['scollector']['tags'] = {
  'environment' => node.chef_environment,
  'role' => node.run_list.roles.first
}

default['go']['packages']           = ['bosun.org/cmd/scollector']
