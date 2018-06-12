# frozen_string_literal: true

module TsAssets
  module Generators
    class ConstGenerator < TsAssets::ApplicationGenerator

      # @return [Hash]
      attr_reader :mapping

      # @param [Hash] mapping
      def initialize(mapping)
        @mapping = mapping
      end

      # @return [TsAssets::Models::Content]
      def generate
        ts_paths = mapping.map { |full_path, asset_meta_info| constify(asset_meta_info) }
        TsAssets::Models::Content.new(header: nil, body: ts_paths.join("\n"))
      end

      # @param [TsAssets::Models::AssetMetaInfo] meta_info
      # @return [String]
      def constify(meta_info)
        <<~TS
          /** #{meta_info.asset_path} */
          const #{meta_info.normalised_path} = "/assets/#{meta_info.digest_path}";
        TS
      end
    end
  end
end
