require 'rake/testtask'
task default: :test

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = true
  t.test_files = FileList['specs/*_spec.rb']
end

# task :test do
#   sh "ruby specs/*_spec.rb -v"
# end
