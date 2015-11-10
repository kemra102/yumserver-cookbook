yum_repository 'nginx' do
  description 'Upstream NGINX repo'
  baseurl 'http://nginx.org/packages/centos/$releasever/$basearch/'
  gpgcheck false
  action :create
end

package 'nginx'

template '/etc/nginx/conf.d/yumserver.conf' do
  cookbook node['yumserver']['nginx']['config_cookbook']
  source 'nginx.erb'
  owner 'nginx'
  group 'nginx'
  mode '0644'
end

conf_dir = node['yumserver']['nginx']['config_directory']

execute 'remove_default_nginx' do
  command "mv #{conf_dir}/default.conf #{conf_dir}/default.conf.deactivated"
  only_if { ::File.exist?('/etc/nginx/conf.d/default.conf') }
end

service 'nginx' do
  action [:enable, :start]
  supports restart: true, reload: true, status: true
  subscribes :restart, 'template[/etc/nginx/conf.d/yumserver.conf]', :delayed
end
