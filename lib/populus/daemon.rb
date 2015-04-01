require 'populus/watch_thread'
require 'securerandom'

module Populus
  module Daemon
    def self.run(name=nil, size=1)
      watches = []
      if name
        watches << name
        puts "creating event: %s" % name
        size -= 1
      end

      size.times do
        watches << (n = "populus-%s" % SecureRandom.hex(2))
        puts "creating event: %s" % n
      end

      threads = watches.map do |_name|
        WatchThread.consul_watch('-type', 'event', '-name', _name)
      end

      trap(:INT) do
        threads.each(&:kill)
      end

      threads.each(&:join)

    end
  end
end
