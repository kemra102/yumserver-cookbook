module YumServer
  # Helper module for yumserver cookbook
  module Helper
    extend Chef::Mixin::ShellOut

    def self.reposync(repo, path, options = '', timeout = '')
      shell_out!("reposync #{options} -d -c /etc/reposync.conf -r #{repo} -p #{path}", timeout: timeout) # rubocop:disable Metrics/LineLength
    end

    def self.createrepo(path, workers)
      shell_out!("createrepo --workers #{workers} -C #{path}")
    end

    def self.rsync(options, url, path, timeout)
      shell_out!("rsync #{options} #{url} #{path}", timeout: timeout)
    end
  end
end
