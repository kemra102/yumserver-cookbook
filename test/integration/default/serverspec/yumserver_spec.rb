require 'serverspec'

set :backend, :exec

describe file('/var/lib/yum-repo') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe package('yum-utils') do
  it { should be_installed }
end

describe package('createrepo') do
  it { should be_installed }
end

describe file('/var/lib/yum-repo/nginx') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe package('nginx') do
  it { should be_installed }
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
