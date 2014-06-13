require "traceur/version"
require "traceur/node"
require "traceur/compiler"

module Traceur
  def self.compile(source, opts = {})
    Compiler.new(source, opts).compile
  end

  def self.node_modules_path
    File.expand_path("../../node_modules", __FILE__)
  end

  def self.runtime
    File.expand_path("traceur/bin/traceur-runtime.js", node_modules_path)
  end
end
