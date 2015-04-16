require 'singleton'
require 'json'

module Populus
  class Pool
    include Singleton

    def objects
      @objects ||= []
    end

    class << self
      def register_object(o)
        instance.objects << o
        puts "Registered: #{o.inspect}"
      end

      # TODO: Trying Enumerable#lazy
      def events
        instance.objects.select {|o| o.type?('event') }
      end

      def find_events_by_name(name)
        events.select{|o| o.has_name?(name) }
      end
    end
  end
end
