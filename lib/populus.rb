module Populus; end

require "populus/do"
require "populus/dsl"
require "populus/daemon"
require "populus/watch_thread"
require "populus/version"

module Populus
  class << self
    attr_accessor :consul_bin
  end

  self.consul_bin = 'consul' # default to count on $PATH
end
