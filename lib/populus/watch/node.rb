module Populus
  module Watch
    class Node
      def initialize
        @on_receive_hooks = []
      end

      def on_receive(&b)
        @on_receive_hooks << &b
      end

      def accept(json)
        @on_receive_hooks.each do |hook|
          begin
            hook.call(json)
          rescue => e
            puts e, "Ignore."
          end
        end
      end
    end
  end
end
