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

%w(yum-utils createrepo rsync).each do |pkg|
  package pkg
end

include_recipe "#{cookbook_name}::_nginx"

if node['yumserver']['zap']
  zap_yum_repos '/etc/yum.repos.d' do
    pattern '*'
    klass [Chef::Resource::YumRepository, Chef::Resource::YumserverMirror,
           Chef::Resource::YumserverRsyncMirror]
    immediately false
  end
end
