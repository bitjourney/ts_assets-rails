require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "ts_assets"

RSpec::Core::RakeTask.new(:spec)

task :generate do
  TS_ASSETS_FILENAME = "__tests__/build/assets.tsx"
  source = TsAssets.generate(include: "__tests__/assets/images")
  File.write TS_ASSETS_FILENAME, source
end

task :default => :spec
