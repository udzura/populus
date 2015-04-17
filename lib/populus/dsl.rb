require 'populus/pool'
require 'populus/node'
require 'populus/accepter'

module Populus

  # Populus.node 'web001.exapmle.jp', 'web002.exapmle.jp'
  #
  # Populus.watch :event, name: "sample" do
  #   cond {|data| data.has_key?('Payload') }
  #   runs do |data|
  #     Populus.logger.info Base64.decode(data['Payload'])
  #   end
  # end
  #
  # Populus.watch :event, name: "sample2" do
  #   cond {|data| data.has_key?('Payload') }
  #   runs do |data|
  #     on 'web001.exapmle.jp' do
  #       execute 'whoami'
  #     end
  #   end
  # end
  module DSL
    class DSLContext
      def initialize(wrap_obj)
        @wrap_obj = wrap_obj
      end

      def cond(&do_foobar)
        @wrap_obj.condition = do_foobar
      end

      def runs(&do_foobar)
        @wrap_obj.runner = do_foobar
      end
    end

    def watch(type, *arg, &b)
      accepter = find_accepter(type.to_s).new(metadata: arg.first)
      DSLContext.new(accepter).instance_eval(&b)
      Pool.register_object accepter
    end

    def node(*nodes)
      nodes.each do |node|
        Node.register_host(node)
      end
    end

    def eval_setting(path)
      load path
    rescue => e
      STDERR.puts "Invalid setting format! #{path}", "error is:", e.class, e.message, e.backtrace
      exit 1
    end

    private

    def find_accepter(type)
      const = type.gsub(/(^.|_.)/) {|c| c.tr('_', '').upcase }
      Accepter.const_get(const)
    end
  end

  extend DSL
end
