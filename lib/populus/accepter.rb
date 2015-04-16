module Populus
  class Accepter
    # TODO: validators
    class Base
      attr_accessor :condition, :runner, :metadata

      def initialize(cond: nil, runs: nil, metadata: {})
        self.condition = cond
        self.runner = runs
        self.metadata = metadata
      end

      def type?(t)
        current_type = self.class.name.downcase
          .split('::')
          .last
        current_type == t
      end

      def accept(data)
        if condition[data]
          Populus.logger.debug "Condition judged true: #{data.inspect}"
          runner[data]
          return true
        else
          Populus.logger.debug "Condition judged false: #{data.inspect}"
          return false
        end
      end
    end

    class Event < Base
      def has_name?(name)
        metadata[:name] == name
      end

      def create_thread
        _name = metadata[:name]
        Populus.logger.debug "Create thread: consul watch -type event -name #{_name}"
        Populus::WatchThread.consul_watch('-type', 'event', '-name', _name)
      end
    end
  end
end
