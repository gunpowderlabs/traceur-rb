require 'tempfile'

module Traceur
  class Compiler
    def initialize(opts = {})
      @runner = opts.fetch(:runner)
      @compile_script_path = opts.fetch(:compile_script_path)
      @default_compilation_options = opts.fetch(:default_compilation_options)
    end

    def compile(source, opts = {})
      options = default_compilation_options.merge(opts)
      infile = Tempfile.new('in.js')
      infile.write(source)
      infile.close
      outfile = Tempfile.new('out.js')
      runner.run(arguments: [compile_script_path, infile.path, outfile.path, options.to_json])
      outfile.read
    end

    private

    attr_reader :runner, :compile_script_path, :default_compilation_options
  end
end
