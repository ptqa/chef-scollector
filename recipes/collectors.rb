#
# Cookbook Name:: scollector
# Recipe:: collectors
#
# Copyright 2015, Twiket Ltd
#

github_url = 'https://raw.githubusercontent.com/onetwotrip/rcollectors/master/'

directory node['scollector']['collectors_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "#{node['scollector']['collectors_dir']}/config.yml" do
  source 'config.yml.erb'
end

if node['scollector']['collectors'][:redis][:enabled]
  interval = node['scollector']['collectors'][:redis][:interval]
  return if interval.nil?

  gem_package 'redis'
  directory "#{node['scollector']['collectors_dir']}/#{interval}" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
  remote_file "#{node['scollector']['collectors_dir']}/#{interval}/redis.rb" do
    source "#{github_url}/redis.rb"
    use_last_modified false # true by default
    owner 'root'
    group 'root'
    mode '755'
  end
end
