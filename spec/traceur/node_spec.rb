require 'spec_helper'

describe Traceur::Node do
  it "evaluates snippets of javascript in node and returns the standard out" do
    out = Traceur::Node.eval('console.log("Hello world!");')

    expect(out).to eq("Hello world!\n")
  end

  it "raises an error if evaluation fails" do
    expect {
      Traceur::Node.eval('undefined.hello();')
    }.to raise_error(Traceur::NodeCommandError)
  end
end
