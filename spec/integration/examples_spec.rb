require 'spec_helper'

describe "Integration tests" do
  def eval_js(script)
    runtime = File.read(Traceur.config.traceur_runtime_path)
    Traceur::Node.eval(runtime + ";" + script)
  end

  def example_file_path(name)
    File.expand_path("../../examples/#{name}", __FILE__)
  end

  def example_file(name)
    File.read(example_file_path(name))
  end

  it "allows compiling strings" do
    compiled = Traceur.compile(example_file('classes.js'))

    expect(eval_js(compiled)).to eq("Hello world!\n")
  end

  it "allows compiling files" do
    compiled = Traceur.compile_file(example_file_path('classes.js'))

    expect(eval_js(compiled)).to eq("Hello world!\n")
  end
end
