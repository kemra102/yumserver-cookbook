yum_repository 'nginx' do
  description 'Upstream NGINX repo'
  baseurl 'http://nginx.org/packages/centos/$releasever/$basearch/'
  gpgcheck false
  action :create
end

package 'nginx'

template '/etc/nginx/conf.d/yumserver' do
  cookbook node['yumserver']['nginx']['config_cookbook']
  source 'nginx.erb'
  owner 'nginx'
  group 'nginx'
  mode '0644'
  variables(
    nginx_servername: 'servername'
  )
end

service 'nginx' do
  action [:enable, :start]
  supports {
    restart: false,
    reload: false,
    status: false
  }
  subscribes :restart, 'template[/etc/nginx/conf.d/yumserver]', :delayed
end
