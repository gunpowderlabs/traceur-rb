module Traceur
  module Node
    class CommandResult < Struct.new(:status, :stdout, :stderr)
      def initialize(opts = {})
        self.status = opts[:status]
        self.stdout = opts[:stdout]
        self.stderr = opts[:stderr]
      end

      def on_error
        yield(self) if error?
        self
      end

      def error?
        !success?
      end

      def success?
        exit_status == 0
      end

      def exit_status
        status.exitstatus
      end
    end
  end
end
