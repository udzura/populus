require 'specinfra'

module Populus
  class Node
    class << self
      def registry
        @nodes ||= {}
      end

      def register_host(hostname)
        registry[hostname] = gen_host(hostname)
      end

      private
      def gen_host(hostname)
        return Specinfra::Backend::Ssh.new(
          host: hostname,
          ssh_options: Populus.config.ssh_options,
          request_pty: true
        )
      end
    end
  end
end
