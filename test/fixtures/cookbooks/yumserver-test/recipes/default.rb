include_recipe 'yumserver'

yumserver_mirror 'nginx' do
  repo_name 'nginx'
  repo_description 'NGINX web server'
  repo_baseurl 'http://nginx.org/packages/centos/7/x86_64/'
  action :create
end

yumserver_rsync_mirror 'centos-virt' do
  repo_name 'centos-virt'
  repo_description 'CentOS Virtualization Packages'
  repo_url 'rsync://mirror.bytemark.co.uk/centos/7/virt/x86_64/'
  action :create
end
