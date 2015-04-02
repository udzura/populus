require 'thread'
require 'open3'

module Populus
  class WatchThread
    def self.consul_watch(*args)
      wait = Thread.fork do
        stdin, stdout, stderr = *Open3.popen3(
          Populus.consul_bin, 'watch', *args, '/bin/cat'
        )
        stdin.close
        while l = stdout.gets
          Populus.logger.info "accept JSON: %s" % l
        end
      end
      return wait
    end
  end
end
