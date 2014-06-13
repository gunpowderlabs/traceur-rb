require 'spec_helper'

describe "Integration tests" do
  def eval_js(script)
    runtime = File.read(Traceur.runtime)
    Traceur::Node.eval(runtime + ";" + script)
  end

  def example_file(name)
    path = File.expand_path("../../examples/#{name}", __FILE__)
    File.read(path)
  end

  it "classes.js example" do
    compiled = Traceur.compile(example_file('classes.js'), modules: "inline")

    expect(eval_js(compiled)).to eq("Hello world!\n")
  end
end
