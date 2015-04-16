require 'populus/watch_thread'
require 'securerandom'

module Populus
  module Daemon
    def self.run(setting: nil)
      raise ArgumentError unless setting
      Populus.eval_setting(setting)
      threads = Populus::Pool.gen_threads

      trap(:INT) do
        STDERR.puts "Caught SIGINT. Quitting..."
        threads.each(&:kill)
      end

      threads.each(&:join)
      Populus.logger.warn "Consul process exited. Aborting..."
    end
  end
end
