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

execute 'remove_default_nginx' do
  command 'mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.deactivated'
  only_if { ::File.exists?('/etc/nginx/conf.d/default.conf') }
end

service 'nginx' do
  action [:enable, :start]
  supports restart: true, reload: true, status: true
  subscribes :restart, 'template[/etc/nginx/conf.d/yumserver.conf]', :delayed
end
