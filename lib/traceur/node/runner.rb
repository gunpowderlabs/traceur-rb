require 'open3'

module Traceur
  module Node
    class Runner
      def initialize(opts = {})
        @binary = opts.fetch(:binary)
        @modules_path = opts.fetch(:modules_path)
        @env = opts.fetch(:env)
      end

      def run(opts = {})
        input = opts.fetch(:input) { "" }
        arguments = opts.fetch(:arguments) { [] }
        on_error = opts.fetch(:on_error) { ->{} }

        Open3.popen3(env, binary, *arguments) do |stdin, stdout, stderr, wait_thr|
          stdin.print input
          stdin.close

          CommandResult.new(
            stdout: stdout.read,
            stderr: stderr.read,
            status: wait_thr.value
          ).on_error(&on_error)
        end
      end

      private

      def env
        @env.merge("NODE_PATH" => modules_path) do |_, old, new|
          "#{old}:#{new}"
        end
      end

      attr_reader :binary, :modules_path
    end
  end
end
