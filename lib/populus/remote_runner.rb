require 'specinfra'

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
  end
end
