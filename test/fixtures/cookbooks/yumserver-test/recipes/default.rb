include_recipe 'yumserver'

yumserver_mirror 'nginx' do
  repo_name 'nginx'
  repo_description 'NGINX web server'
  repo_baseurl 'http://nginx.org/packages/centos/7/x86_64/'
  action :create
end
