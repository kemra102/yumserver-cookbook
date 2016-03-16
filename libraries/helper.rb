module YumServer
  # Helper module for yumserver cookbook
  module Helper
    extend Chef::Mixin::ShellOut

    def self.reposync(repo, path, newest_only)
      if newest_only
        opt = '-n'
      else
        opt = ''
      end
      shell_out!("reposync #{newest_only} -d -c /etc/reposync.conf -r #{repo} -p #{path}")
    end

    def self.createrepo(path)
      shell_out!("createrepo -C #{path}")
    end

    def self.rsync(options, url, path)
      shell_out!("rsync #{options} #{url} #{path}")
    end
  end
end
