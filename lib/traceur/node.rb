require "traceur/node/runner"
require "traceur/node/command_result"

module Traceur
  class NodeCommandError < StandardError
  end

  module Node
    def self.eval(script)
      Traceur.node_runner.run(
        input: script,
        on_error: ->(r){raise_command_error(r)}).stdout
    end

    def self.exec(*args)
      Traceur.node_runner.run(
        arguments: args,
        on_error: ->(r){raise_command_error(r)}).stdout
    end

    def self.raise_command_error(result)
      raise NodeCommandError,
        "Node command returned non-0 exit status: #{result.exit_status}. Stderr was:\n#{result.stderr}"
    end
  end
end
