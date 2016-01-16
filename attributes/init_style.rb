# Systemd for CentOS by default
default['scollector']['init_style'] = node['platform'] == 'centos' ? 'systemd' : 'runit'
