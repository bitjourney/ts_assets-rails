require 'ts_assets/version'
require 'ts_assets/application_generator'

require 'ts_assets/generators/const_generator'
require 'ts_assets/generators/react_generator'

require 'ts_assets/models/asset_meta_info'
require 'ts_assets/models/content'

module TsAssets
  def self.generate(**opts)
    TsAssets::ApplicationGenerator.new(**opts).generate
  end
end
