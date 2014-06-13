require "traceur/version"
require "traceur/node"
require "traceur/compiler"

module Traceur
  def self.compile(source, opts = {})
    Compiler.new(source, opts).compile
  end

  def self.node_binary
    "node"
  end

  def self.node_modules_path
    File.expand_path("../../vendor/node_modules", __FILE__)
  end

  def self.runtime
    File.expand_path("traceur/bin/traceur-runtime.js", node_modules_path)
  end

  def self.node_runner(opts = {})
    Node::Runner.new({
      binary: Traceur.node_binary,
      modules_path: Traceur.node_modules_path,
      env: ENV.to_hash
    }.merge(opts))
  end
end
