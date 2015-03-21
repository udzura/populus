require 'populus/do'
require 'populus/watch/node'

module Populus
  module DSL
    def watch(arg, &b)
      watching = find_watch_obj(arg)
      watching.instance_eval &b
      Do.register_object watching
    end

    def find_watch_obj(arg)
      const = arg.gsub(/(^.|_.)/) {|c| c.tr('_', '').upcase }
      Watch.const_get(const).new
    end
  end

  extend DSL
end
