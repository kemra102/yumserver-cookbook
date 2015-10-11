#
# Cookbook Name:: yumserver
# Recipe:: default
#
# Copyright 2015, Danny Roberts
#
# License: BSD-2-Clause
#
directory node['yumserver']['basepath'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

%w( yum-utils createrepo ).each do |pkg|
  package pkg
end

httpd_service 'default' do
  servername node['yumserver']['httpd']['servername']
  listen_ports node['yumserver']['httpd']['port']
  action :create
end
httpd_config 'default' do
  source 'httpd.conf.erb'
  variables httpd: {
    server_name: node['yumserver']['httpd']['servername']
  }
  action :create
end
