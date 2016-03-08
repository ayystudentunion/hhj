desc 'Run all tests'

task test: [:spec, :cucumber]

namespace :ci do
  task test: 'rake:test'
end
