require 'populus/pool'
require 'populus/accepter'

module Populus

  # Populus.watch :event, name: "sample" do
  #   When {|data| data.has_key?('Payload') }
  #   Runs do |data|
  #     Populus.logger.info Base64.decode(data['Payload'])
  #   end
  # end
  module DSL
    class DSLContext
      def initialize(wrap_obj)
        @wrap_obj = wrap_obj
      end

      def When(&do_foobar)
        @wrap_obj.condition = do_foobar
      end

      def Runs(&do_foobar)
        @wrap_obj.runner = do_foobar
      end
    end

    def watch(type, *arg, &b)
      accepter = find_accepter(type.to_s).new(metadata: arg.first)
      DSLContext.new(accepter).instance_eval(&b)
      Pool.register_object accepter
    end

    def find_accepter(type)
      const = type.gsub(/(^.|_.)/) {|c| c.tr('_', '').upcase }
      Accepter.const_get(const)
    end

    def eval_setting(path)
      load path
    rescue => e
      STDERR.puts "Invalid setting format! #{path}", "error is:", e.class, e.message, e.backtrace
      exit 1
    end
  end

  extend DSL
end
