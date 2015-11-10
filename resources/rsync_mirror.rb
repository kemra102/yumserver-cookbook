property :name, [String, Symbol], required: true, name_property: true
property :local_path, String, required: false
property :repo_name, String, required: true
property :repo_description, String, required: true
property :repo_url, String, required: true
property :rsync_options, String, required: false,
                                 default: '-aHS --numeric-ids --delete \
                                 --delete-delay --delay-updates'

def real_local_path
  if local_path == NilClass
    "#{local_path}/#{name}/"
  else
    "/var/lib/yum-repo/#{name}/"
  end
end

action :create do
  directory real_local_path do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
  ruby_block 'reposync' do
    block do
      system "rsync #{rsync_options} #{repo_url} #{real_local_path}"
    end
  end
end

action :delete do
  directory real_local_path do
    action :delete
  end
end
