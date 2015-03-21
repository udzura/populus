require 'singleton'
require 'json'

module Populus
  class Do
    include Singleton
    def objects
      @objects ||= []
    end

    class << self
      def register_object(o)
        instance.objects << o
        puts "Registered: #{o.inspect}"
      end

      def accept(input)
        json = JSON.parse(input)
        instance.objects.each do |o|
          o.accept json
        end
      end
    end
  end
end
