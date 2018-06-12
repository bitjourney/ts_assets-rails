require "bundler/gem_tasks"
require "ts_assets"

namespace :test do
  desc 'generate asset.tsx for testing'
  task :ts_assets do
    TS_ASSETS_FILENAME = "__tests__/build/assets.tsx"
    source = TsAssets.generate(include: "__tests__/assets/images", es_module_interop: true)
    File.write TS_ASSETS_FILENAME, source
  end
end

task :test => ['test:ts_assets'] do
  sh 'npm', 'test'
end

task :default => :test
