#
# Cookbook Name:: scollector
# Recipe:: default
#
# Copyright 2015, Twiket Ltd
#
include_recipe "runit"

cookbook_file "/usr/local/bin/scollector" do
  source "scollector-linux-amd64"
  action :create
  mode '0755'
end

runlist_roles = node.run_list.roles

variables =  Mash.new
variables['environment'] = node.chef_environment.gsub("_", "")
variables['role'] = 'undefined'
role0 = runlist_roles[0]
variables['role'] = runlist_roles[0] unless (role0.nil? or role0 == '')

template "/usr/local/bin/scollector.conf" do
  mode 0644
  source "scollector.conf.erb"
  variables variables
end

runit_service "scollector" do
  run_template_name 'scollector'
  restart_on_update true
end
