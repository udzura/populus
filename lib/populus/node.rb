require 'specinfra'

module Populus
  class Node
    class << self
      def registory
        @nodes ||= {}
      end

      def register_host(hostname)
        @nodes[hostname] = gen_host(hostname)
      end

      private
      def gen_host(hostname)
        return Specinfra::Backend::Ssh.new(
          host: hostname,
          ssh_options: Populus.config.ssh_options
        )
      end
    end
  end
end
