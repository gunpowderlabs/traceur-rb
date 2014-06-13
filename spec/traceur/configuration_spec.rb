require 'spec_helper'

describe Traceur::Configuration do
  let(:config) { Traceur::Configuration.new }
  let(:root_dir) { File.expand_path("../../..", __FILE__) }

  it "allows configuring the node binary" do
    config.node_binary = "nodejs"
    expect(config.node_binary).to eq("nodejs")
  end

  it "allows configuring the node modules path" do
    config.node_modules_path = "/var/lib/node_modules"
    expect(config.node_modules_path).to eq("/var/lib/node_modules")
  end

  it "allows configuring the traceur runtime script path" do
    config.traceur_runtime_path = "/var/lib/traceur-runtime.js"
    expect(config.traceur_runtime_path).to eq("/var/lib/traceur-runtime.js")
  end

  it "allows configuring the compile script path" do
    config.compile_script_path = "/my/compile.js"
    expect(config.compile_script_path).to eq("/my/compile.js")
  end

  it "defaults node binary to node" do
    expect(config.node_binary).to eq("node")
  end

  it "defaults node_modules_path to vendor dir bundled with this gem" do
    expect(config.node_modules_path.to_s).to eq(root_dir + "/vendor/node_modules")
  end

  it "defaults traceur_runtime_path to the bundled version" do
    expect(config.traceur_runtime_path.to_s).to eq(root_dir + "/vendor/node_modules/traceur/bin/traceur-runtime.js")
  end

  it "defaults compile script path to local file" do
    expect(config.compile_script_path.to_s).to eq(root_dir + "/lib/js/compile.js")
  end
end
