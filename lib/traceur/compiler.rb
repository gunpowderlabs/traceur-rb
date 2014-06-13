require 'tempfile'
require 'json'

module Traceur
  class Compiler
    attr_reader :source, :opts

    def initialize(source, opts = {})
      @source = source
      @opts = opts
    end

    def compile
      compiler_js = File.expand_path("../../js/compile.js", __FILE__)
      infile = Tempfile.new('in.js')
      infile.write(source)
      infile.close
      outfile = Tempfile.new('out.js')
      Node.exec(compiler_js, infile.path, outfile.path, opts.to_json)
      outfile.read
    end
  end
end
