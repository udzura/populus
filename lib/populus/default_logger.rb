require 'logger'
require 'colorize'
module Populus
  class DefaultLoggerFormatter < ::Logger::Formatter
    COLOR_CODE = {
      'DEBUG' => :black,
      'INFO'  => :green,
      'WARN'  => :yellow,
      'ERROR' => :red,
      'FATAL' => :magenta,
    }

    def call(severity, time, progname, msg)
      s = super
      s[0] = ("%5s" % severity).colorize(:color => COLOR_CODE[severity])
      s
    end
  end

  logger = ::Logger.new(STDOUT)
  logger.level = ::Logger::DEBUG
  logger.formatter = DefaultLoggerFormatter.new
  DefaultLogger = logger
end
