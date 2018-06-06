# frozen_string_literal: true

task :run_myway do
  system('puma')
end

task :test_myway do
  system('rspec')
end