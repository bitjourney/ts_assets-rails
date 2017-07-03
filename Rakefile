require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "ts_assets"

RSpec::Core::RakeTask.new(:spec)

task :generate do
  TS_ASSETS_FILENAME = "spec/build/assets.tsx"
  source = TsAssets.generate(include: "spec/assets/images")
  File.write TS_ASSETS_FILENAME, source
end

task :default => :spec
