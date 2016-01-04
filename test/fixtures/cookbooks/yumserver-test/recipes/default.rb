include_recipe 'yumserver'

major_ver = node['platform_version']

yumserver_mirror 'nginx' do
  repo_name 'nginx'
  repo_description 'NGINX web server'
  repo_baseurl "http://nginx.org/packages/centos/#{major_ver[/./,0]}/x86_64/"
  action :create
end

yumserver_rsync_mirror 'centos-xen' do
  repo_name 'centos-xen'
  repo_description 'CentOS Virtualization Packages'
  repo_url "rsync://mirror.bytemark.co.uk/centos/#{major_ver[/./,0]}/virt/x86_64/xen/"
  action :create
end
