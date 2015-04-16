require 'thread'
require 'open3'

require 'populus/pool'
require 'json'

module Populus
  class WatchThread
    def self.consul_watch(*args)
      wait = Thread.fork do
        stdin, stdout, stderr = *Open3.popen3(
          Populus.consul_bin, 'watch', *args, '/bin/cat'
        )
        stdin.close
        name = args[args.index('-name') + 1]
        accepters = Populus::Pool.find_events_by_name(name)
        while l = stdout.gets
          Populus.logger.debug "accept JSON: %s" % l
          data = JSON.parse l

          accepters.each do |accepter|
            begin
              accepter.accept(data)
            rescue => e
              Populus.logger.warn "Error on event: %s, %s. Skip." % [e.class, e.message]
            end
          end
        end
      end
      return wait
    end
  end
end
