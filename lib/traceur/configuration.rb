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
      @node_modules_path ||= root_dir.join("node_modules")
    end

    def traceur_runtime_path
      @traceur_runtime_path ||= node_modules_path.join("traceur", "bin", "traceur-runtime.js")
    end

    def assets_path
      traceur_runtime_path.dirname.to_s
    end

    def compile_script_path
      @compile_script_path ||= root_dir.join("lib", "js", "compile.js")
    end

    def default_compilation_options
      @default_compilation_options ||= CompilationOptions.new(
        modules: :inline,
        source_maps: :inline,
      )
    end

    def default_compilation_options=(hash)
      @default_compilation_options = CompilationOptions.new(hash)
    end

    private

    def root_dir
      Pathname.new(__FILE__).join("..", "..", "..")
    end
  end
end
