require 'populus/watch_thread'
require 'securerandom'

module Populus
  module Daemon
    def self.run(name=nil, size=1)
      watches = []
      if name
        watches << name
        Populus.logger.info "creating event: %s" % name
        size -= 1
      end

      size.times do
        watches << (n = "populus-%s" % SecureRandom.hex(2))
        Populus.logger.info "creating event: %s" % n
      end

      threads = watches.map do |_name|
        Populus.logger.debug "Create thread: consul watch -type event -name #{_name}"
        WatchThread.consul_watch('-type', 'event', '-name', _name)
      end

      trap(:INT) do
        STDERR.puts "Caught SIGINT. Quitting..."
        threads.each(&:kill)
      end

      threads.each(&:join)
        Populus.logger.warn "Consul process exited. Aborting..."
    end
  end
end
