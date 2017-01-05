property :name, [String, Symbol], required: true, name_property: true
property :local_path, String, required: false
property :repo_name, String, required: true
property :repo_description, String, required: true
property :repo_url, String, required: true
property :timeout, Integer, required: false, default: 600
property :rsync_options, String, required: false,
                                 default: '-aHS --numeric-ids --delete \
                                 --delete-delay --delay-updates'
property :use_repo, [TrueClass, FalseClass], required: true, default: true

def real_local_path
  if local_path == NilClass
    "#{local_path}/#{name}/"
  else
    "#{node['yumserver']['basepath']}/#{name}/"
  end
end

def path
  real_local_path
end

action :create do
  directory real_local_path do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
  ruby_block 'rsync' do
    block do
      YumServer::Helper.rsync(rsync_options, repo_url, real_local_path,
                              new_resource.timeout)
    end
  end
  if use_repo
    yum_repository repo_name do
      description repo_description
      baseurl "file://#{real_local_path}"
      gpgcheck false
      action :create
    end
  end
end

action :delete do
  directory real_local_path do
    recursive true
    action :delete
  end
  yum_repository repo_name do
    action :delete
  end
end
