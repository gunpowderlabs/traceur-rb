require "traceur/version"
require "traceur/configuration"
require "traceur/compilation_error"
require "traceur/compilation_options"
require "traceur/node"
require "traceur/compiler"

module Traceur
  def self.compile(source, opts = {})
    compiler.compile(source, opts)
  end

  def self.compile_file(source_file, opts = {})
    compiler.compile_file(File.new(source_file), {filename: source_file}.merge(opts))
  end

  def self.config
    @config ||= Configuration.new
    yield @config if block_given?
    @config
  end

  def self.assets_path
    config.assets_path
  end

  def self.configure
    yield config
  end

  def self.node_runner(opts = {})
    Node::Runner.new({
      binary: config.node_binary.to_s,
      modules_path: config.node_modules_path.to_s,
      env: ENV.to_hash
    }.merge(opts))
  end

  def self.compiler
    Compiler.new(runner: node_runner,
                 compile_script_path: config.compile_script_path.to_s,
                 default_compilation_options: config.default_compilation_options)
  end
end
