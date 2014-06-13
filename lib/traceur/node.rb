require 'open3'

module Traceur
  def self.node_binary
    "node"
  end

  class NodeCommandError < StandardError
  end

  module Node
    def self.eval(script)
      NodeCommand.new(Traceur.node_binary, [], script).stdout
    end

    def self.exec(*args)
      NodeCommand.new(Traceur.node_binary, args).stdout
    end

    class NodeCommand
      def initialize(node_binary, arguments, script = "")
        @node_binary = node_binary
        @arguments = arguments
        @script = script
      end

      def stdout
        lazy{ @stdout }
      end

      def stderr
        lazy { @stderr }
      end

      private

      attr_reader :node_binary, :arguments, :script, :status

      def lazy
        execute unless status
        yield
      end

      def ensure_completed_successfully
        exit_status = status.exitstatus
        return if exit_status == 0
        raise NodeCommandError, "Node command returned non-0 exit status: #{exit_status}. Stderr was:\n#{stderr}"
      end

      def execute
        Open3.popen3(node_binary, *arguments) do |stdin, stdout, stderr, wait_thr|
          stdin.print @script
          stdin.close

          @stdout = stdout.read
          @stderr = stderr.read
          @status = wait_thr.value
        end
        ensure_completed_successfully
      end
    end
  end
end
