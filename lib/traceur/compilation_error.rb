module Traceur
  class CompilationError < StandardError
    attr_reader :errors

    def initialize(errors)
      @errors = errors
      super(errors.map(&:to_s).join("\n"))
    end

    def self.parse(error_string)
      lines = error_string.split("\n")

      errors = lines.map do |line|
        file, line, column, message = line.split(':')
        Error.new(file.strip, line.to_i, column.to_i, message.strip)
      end

      new(errors)
    end

    Error = Struct.new(:file, :line, :column, :message) do
      def to_s
        "#{file}:#{line}:#{column}: #{message}"
      end
    end
  end
end
