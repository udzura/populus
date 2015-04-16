module Populus
  class Accepter
    class Base
      attr_accessor :condition, :runner, :metadata

      def initialize(cond, runs, metadata)
        self.condition = cond
        self.runner = runs
        self.metadata = matadata
      end

      def type?(t)
        self.class.name.downcase == t
      end

      def accept(data)
        if condition[data]
          runner[data]
          return true
        else
          return false
        end
      end
    end

    class Event < Base
      def has_name?(name)
        metadata[:name] == name
      end
    end
  end
end
