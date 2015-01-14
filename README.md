# traceur-rb

This gem provides a Ruby wrapper around [Google Traceur][gtraceur].

## Google Traceur

Google Traceur is a transpiler, which allows you to compile ECMAScript 6 (JS.next) features in today's browsers.

## Dependencies

Google Traceur depends on Node.js. On Ubuntu, you can install Node.js with command:

```bash
sudo apt-get install node
```

## Installation

Add this line to your application's Gemfile:

    gem 'traceur-rb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install traceur-rb

## Basic Usage

You can compile a snippet of ECMAScript 6 by calling the following method:

```ruby
require 'traceur'

compiled_source = Traceur.compile(es6_source, additional_compilation_flags) 
```

similarly, you can compile a file using:

```ruby
require 'traceur'

compiled_source = Traceur.compile_file(path_to_es6_file, additional_compilation_flags)
```

## Configuration

traceur-rb can be configured using a `Traceur.configure`:

```ruby
Traceur.configure do |c|
  # Configure path of the node.js binary.
  # By default, traceur-rb loooks for node in $PATH.
  c.node_binary = "/path/to/node"

  # Configure path of node_modules folder, where
  # traceur is installed.
  # By default, traceur-rb uses traceur version
  # which comes bundled with the gem.
  c.node_modules_path = "/path/to/node_modules/"

  # Configure path to traceur-runtime.js, which is
  # a runtime dependency of the code compiled using
  # Google Traceur.
  # By default, this is computed based on node_modules_path.
  c.traceur_runtime_path = "/path/to/node_modules/traceur/bin/traceur-runtime.js"

  # Configure the default compilation options.
  # For a complete list of options available, see:
  # https://github.com/google/traceur-compiler/wiki/Options-for-Compiling
  c.default_compilation_options.modules = :amd
  c.default_compilation_options.source_map = true
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/traceur-rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[gtraceur]: https://github.com/google/traceur-compiler
