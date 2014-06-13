require 'open3'

module Traceur
  class NodeCommandError < StandardError
  end

  module Node
    def self.eval(script)
      NodeCommand.new(input: script).stdout
    end

    def self.exec(*args)
      NodeCommand.new(arguments: args).stdout
    end

    class NodeCommand
      def initialize(opts = {})
        @node_binary = opts.fetch(:binary) { Traceur.node_binary }
        @node_modules_path = opts.fetch(:node_modules_path) { Traceur.node_modules_path }
        @arguments = opts.fetch(:arguments) { [] }
        @script = opts.fetch(:input) { "" }
      end

      def stdout
        lazy{ @stdout }
      end

      def stderr
        lazy { @stderr }
      end

      private

      attr_reader :node_binary, :node_modules_path, :arguments, :script, :status

      def lazy
        execute unless status
        yield
      end

      def ensure_completed_successfully
        exit_status = status.exitstatus
        return if exit_status == 0
        raise NodeCommandError, "Node command returned non-0 exit status: #{exit_status}. Stderr was:\n#{stderr}"
      end

      def env
        ENV.to_hash.merge("NODE_PATH" => node_modules_path) do |_, old, new|
          "#{old}:#{new}"
        end
      end

      def execute
        Open3.popen3(env, node_binary, *arguments) do |stdin, stdout, stderr, wait_thr|
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
