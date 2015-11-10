require 'serverspec'

set :backend, :exec

%w(yum-utils createrepo rsync nginx).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

%w(/var/lib/yum-repo /var/lib/yum-repo/nginx
   /var/lib/yum-repo/nginx/repodata).each do |dir|
  describe file(dir) do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end

%w(/var/lib/yum-repo/centos-virt
   /var/lib/yum-repo/centos-virt/xen).each do |dir|
  describe file(dir) do
    it { should be_directory }
  end
end

describe file('/etc/nginx/conf.d/yumserver.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'nginx' }
  it { should be_grouped_into 'nginx' }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end
