require 'pathname'

module Traceur
  class Configuration
    attr_writer :node_binary
    attr_writer :node_modules_path
    attr_writer :traceur_runtime_path
    attr_writer :compile_script_path

    def node_binary
      @node_binary ||= "node"
    end

    def node_modules_path
      @node_modules_path ||= root_dir.join("vendor", "node_modules")
    end

    def traceur_runtime_path
      @traceur_runtime_path ||= node_modules_path.join("traceur", "bin", "traceur-runtime.js")
    end

    def compile_script_path
      @compile_script_path ||= root_dir.join("lib", "js", "compile.js")
    end

    private

    def root_dir
      Pathname.new(__FILE__).join("..", "..", "..")
    end
  end
end
