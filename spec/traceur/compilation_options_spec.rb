require 'spec_helper'

describe Traceur::CompilationOptions do
  let(:options) { Traceur::CompilationOptions.new }

  it "converts snake_case names camelCase" do
    options.some_option_name = "foo"

    expect(options.to_hash).to eq(someOptionName: "foo")
  end

  it "allows reading back set names" do
    options.some_option_name = "foo"

    expect(options.some_option_name).to eq("foo")
  end

  it "can be initialized with a hash" do
    options = Traceur::CompilationOptions.new(foo: 1, module_name: 'bar')

    expect(options.to_hash).to eq(foo: 1, moduleName: 'bar')
  end

  it "can be merged with a hash" do
    options.merge!(foo: 2, bar: 3)
    new_options = options.merge(foo: 1, module_name: 'bar')

    expect(new_options.to_hash).to eq(foo: 1, bar: 3, moduleName: 'bar')
    expect(options.to_hash).to eq(foo: 2, bar: 3)
  end
end
