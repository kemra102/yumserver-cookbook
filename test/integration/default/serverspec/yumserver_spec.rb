require 'serverspec'

set :backend, :exec

%w(yum-utils createrepo rsync nginx).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/etc/reposync.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

%w(/etc/reposync.repos.d /yum /yum/nginx /yum/nginx/repodata).each do |dir|
  describe file(dir) do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end

describe file('/etc/reposync.repos.d/nginx.repo') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

%w(/yum/centos-xen /yum/centos-xen/repodata).each do |dir|
  describe file(dir) do
    it { should be_directory }
  end
end

describe file('/etc/nginx/conf.d/yumserver.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'root /yum;' }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end
