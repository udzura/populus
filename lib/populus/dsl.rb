require 'populus/do'
require 'populus/watch/node'

module Populus

  # Populus.watch :event, name: "sample" do
  #   when {|data| data.has_key?('Payload') }
  #   runs do |data|
  #     Populus.logger.info Base64.decode(data['Payload'])
  #   end
  # end
  module DSL
    def watch(arg, &b)
      watching = find_watch_obj(arg)
      watching.instance_eval(&b)
      Pool.register_object watching
    end

    def find_watch_obj(arg)
      const = arg.gsub(/(^.|_.)/) {|c| c.tr('_', '').upcase }
      Watch.const_get(const).new
    end

    def eval_setting(path)
      load path
    rescue => e
      STDERR.puts "Invalid setting format! #{path}", "error is:", e
      exit 1
    end
  end

  extend DSL
end
