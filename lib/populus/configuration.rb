require 'populus'

module Populus
  class Configuration
    def initialize
      @pool = {}
    end

    def set(key, value)
      true_value = case value
                   when Proc
                     value
                   else
                     lambda { value }
                   end
      self.define_singleton_method key do
        @pool[key] || (
          @pool[key] = true_value.call
        )
      end
    end

    def method_missing(meth, *args)
      raise NameError, "Populus::Configuration value #{meth} is not yet defined"
    end
  end

  def self.config(&config_block)
    @_config ||= Configuration.new
    if block_given?
      @_config.instance_eval(&config_block)
    end
    @_config
  end
end
