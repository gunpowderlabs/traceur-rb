require 'tempfile'

module Traceur
  class Compiler
    def initialize(opts = {})
      @runner = opts.fetch(:runner)
      @compile_script_path = opts.fetch(:compile_script_path)
      @default_compilation_options = opts.fetch(:default_compilation_options)
    end

    def compile(source, opts = {})
      compile_file(tempfile(source), opts)
    end

    def compile_file(infile, opts = {})
      options = default_compilation_options.merge(opts)
      outfile = Tempfile.new('out.js')
      runner.run(
        arguments: [compile_script_path, infile.path, outfile.path, options.to_json],
        on_error: ->(r) { raise CompilationError.parse(r.stderr) }
      ).stdout
      outfile.read
    end

    private

    def tempfile(source)
      Tempfile.new('in.js').tap do |f|
        f.write(source)
        f.close
      end
    end

    attr_reader :runner, :compile_script_path, :default_compilation_options
  end
end
