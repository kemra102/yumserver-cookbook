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

directory '/etc/reposync.repos.d/' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/reposync.conf' do
  cookbook 'yumserver'
  source 'reposync.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

%w(yum-utils createrepo rsync).each do |pkg|
  package pkg
end

include_recipe "#{cookbook_name}::_nginx"
