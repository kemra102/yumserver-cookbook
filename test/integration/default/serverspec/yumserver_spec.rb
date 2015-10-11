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
