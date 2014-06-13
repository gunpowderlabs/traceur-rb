require "traceur/version"
require "traceur/configuration"
require "traceur/node"
require "traceur/compiler"

module Traceur
  def self.compile(source, opts = {})
    compiler.compile(source, opts)
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end

  def self.runtime
    config.traceur_runtime_path
  end

  def self.node_runner(opts = {})
    Node::Runner.new({
      binary: config.node_binary.to_s,
      modules_path: config.node_modules_path.to_s,
      env: ENV.to_hash
    }.merge(opts))
  end

  def self.compiler
    Compiler.new(node_runner, config.compile_script_path.to_s)
  end
end
