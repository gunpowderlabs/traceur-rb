require 'json'

module Traceur
  class CompilationOptions
    def initialize(options = {})
      @options = {}
      merge!(options)
    end

    def []=(name, value)
      @options[normalize(name)] = value
    end

    def [](name)
      @options[normalize(name)]
    end

    def merge!(options)
      options.each do |key, value|
        self[key] = value
      end
      self
    end

    def merge(options)
      CompilationOptions.new(self).merge!(options)
    end

    def each(&block)
      @options.each(&block)
    end

    def to_hash
      @options
    end

    def to_json
      to_hash.to_json
    end

    private

    def respond_to_missing?(name, include_private)
      true
    end

    def method_missing(name, *args, &block)
      return self[name] = args.first if setter?(name, args)
      return self[name] if getter?(name, args)
      super
    end

    def setter?(name, args)
      name.to_s.end_with?("=") && args.size == 1
    end

    def getter?(name, args)
      args.size == 0
    end

    def normalize(name)
      name.to_s.gsub(/_[a-z]/) { |m| m.upcase }.gsub('_', '').gsub(/=$/, '').to_sym
    end
  end
end
