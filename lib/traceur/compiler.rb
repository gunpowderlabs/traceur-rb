require 'tempfile'
require 'json'

module Traceur
  class Compiler
    def initialize(runner, compile_script_path)
      @runner = runner
      @compile_script_path = compile_script_path
    end

    def compile(source, opts = {})
      infile = Tempfile.new('in.js')
      infile.write(source)
      infile.close
      outfile = Tempfile.new('out.js')
      runner.run(arguments: [compile_script_path, infile.path, outfile.path, opts.to_json])
      outfile.read
    end

    private

    attr_reader :runner, :compile_script_path
  end
end
