module YumServer
  # Helper module for yumserver cookbook
  module Helper
    extend Chef::Mixin::ShellOut

    def self.reposync(repo, path)
      shell_out!("reposync -d -c /etc/reposync.conf -r #{repo} -p #{path}")
    end
  end
end
