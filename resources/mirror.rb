property :name, [String, Symbol], required: true, name_property: true
property :local_path, String, required: false
property :repo_name, String, required: true
property :repo_description, String, required: true
property :repo_baseurl, String, required: true

def real_local_path
  if local_path == NilClass
    "#{local_path}/#{name}/"
  else
    "/var/lib/yum-repo/#{name}/"
  end
end

action :create do
  yum_repository repo_name do
    description repo_description
    baseurl repo_baseurl
    gpgcheck false
    action :create
  end
  directory real_local_path do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
  ruby_block 'reposync' do
    block do
      system "reposync -r #{repo_name} -p #{real_local_path}"
    end
  end
  ruby_block 'createrepo' do
    block do
      system "createrepo #{real_local_path}"
    end
  end
end

action :delete do
  yum_repository repo_name do
    action :delete
  end
  directory real_local_path do
    action :delete
  end
end
