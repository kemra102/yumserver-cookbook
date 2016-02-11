name 'yumserver'
maintainer 'Danny Roberts'
maintainer_email 'danny@thefallenphoenix.net'
license 'BSD-2-Clause'
description 'Installs/Configures yumserver & mirrors remote repos.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.1'

%w(centos oracle redhat scientific).each do |os|
  supports os, '>= 6.0'
end

source_url 'https://github.com/kemra102/yumserver-cookbook' if
  respond_to?(:source_url)
issues_url 'https://github.com/kemra102/yumserver-cookbook/issues' if
  respond_to?(:issues_url)

depends 'nginx_server', '>= 1.0.1'
depends 'zap', '>= 0.10.0'
depends 'yum', '>= 3.5.2'
