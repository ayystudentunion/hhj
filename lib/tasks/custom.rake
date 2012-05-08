desc "Run all tests"
task :testall => [:setenv, :spec, :cucumber]

task :setenv do
  ENV["RAILS_ENV"] = 'test'
end

