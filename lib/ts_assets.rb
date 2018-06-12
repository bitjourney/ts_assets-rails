# frozen_string_literal: true

require_relative 'ts_assets/version'
require_relative 'ts_assets/application_generator'

require_relative 'ts_assets/generators/const_generator'
require_relative 'ts_assets/generators/react_generator'

require_relative 'ts_assets/models/asset_meta_info'
require_relative 'ts_assets/models/content'

module TsAssets
  def self.generate(**opts)
    TsAssets::ApplicationGenerator.new(**opts).generate
  end
end
