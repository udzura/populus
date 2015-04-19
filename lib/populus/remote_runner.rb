require 'specinfra'
require 'erb'
require 'tempfile'
require 'fileutils'

module Populus
  class RemoteRunner
    def initialize(backend, &run_it)
      @backend = backend
      instance_exec(&run_it)
    end

    def execute(*command)
      Populus.logger.info("Running command: %s" % command.inspect)

      res = @backend.run_command(command.join(" "))
      Populus.logger.debug("stdout:\n%s" % res.stdout)
      Populus.logger.debug("stderr:\n%s" % res.stderr)
      Populus.logger.info("Command exited: %d" % res.exit_status)
    end

    def create_file(path, template="", context=nil)
      file = Tempfile.new(".populus-tmp")
      content = ERB.new(template).result(context || binding)
      file.write content
      file.close
      @backend.send_file(file.path, path)
      Populus.logger.info("Created Successfully: %s" % path)

      FileUtils.rm_f(file.path)
    end

  end
end
