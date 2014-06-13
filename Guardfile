# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, failed_mode: :keep do
  watch(%r{^spec/.+_spec\.rb$}) { "spec" }
  watch(%r{^lib/(.+)\.(rb|js)$}) { "spec" }
  watch('spec/spec_helper.rb') { "spec" }
end
