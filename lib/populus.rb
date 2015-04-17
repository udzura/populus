module Populus; end

require "logger"
require "populus/default_logger"

module Populus
  class << self
    attr_accessor :consul_bin, :logger
  end

  self.consul_bin = 'consul' # default to count on $PATH
  self.logger = Populus::DefaultLogger
end

require "populus/pool"
require "populus/helpers"
require "populus/configuration"
require "populus/dsl"
require "populus/daemon"
require "populus/watch_thread"
require "populus/version"
