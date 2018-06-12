# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'

module TsAssets
  module Generators
    class ReactGenerator < TsAssets::ApplicationGenerator

      # @return [Hash]
      attr_reader :mapping

      # @return [Boolean]
      attr_reader :es_module_interop

      # @param [Hash] mapping
      def initialize(mapping, es_module_interop: false)
        @mapping = merge_mapping_with_same_descriptors(mapping)
        @es_module_interop = es_module_interop
      end

      # @return [TsAssets::Models::Content]
      def generate
        components = mapping.map { |path, asset_meta_infos| reactify(path, asset_meta_infos) }
        TsAssets::Models::Content.new(header: header, body: components.join("\n"))
      end

      private

      # @param [Hash<String, TsAssets::Models::AssetMetaInfo>] mapping
      # @return [Hash<String, [TsAssets::Models::AssetMetaInfo]>]
      def merge_mapping_with_same_descriptors(mapping)
        new_mapping = {}

        mapping.map do |full_path, asset_meta_info|
          path = asset_meta_info.asset_path_without_descriptor

          if new_mapping[path].nil?
            new_mapping[path] = [asset_meta_info]
          else
            new_mapping[path] << asset_meta_info
          end
        end

        new_mapping
      end

      # @return [String]
      def header
        if es_module_interop
          <<~TYPESCRIPT
            import React from "react";
          TYPESCRIPT
        else
          <<~TYPESCRIPT
            import * as React from "react";
          TYPESCRIPT
        end
      end

      # @param [String] path
      # @param [Array<AssetMetaInfo>] asset_meta_infos
      # @return [String]
      def reactify(path, asset_meta_infos)
        component_name = build_component_name(path)

        alt = File.basename(path)
        width = asset_meta_infos.first.width
        height = asset_meta_infos.first.height
        src = asset_meta_infos.first.normalised_path
        src_set = build_src_set(asset_meta_infos)

        <<~TS
          /** #{path} */
          export function #{component_name}(props?: React.DetailedHTMLProps<React.ImgHTMLAttributes<HTMLImageElement>, HTMLImageElement>) {
              return <img alt="#{alt}"
                          width={#{width}}
                          height={#{height}}
                          src={#{src}}
                          srcSet={#{src_set}}
                          {...props}
                          />;
          }
        TS
      end

      # @param [String] asset_path
      # @return [String]
      def build_component_name(asset_path)
        "Image#{asset_path.gsub(/[^a-zA-Z0-9_]/, '_').camelize}"
      end

      # @param [Array<AssetMetaInfo>] asset_meta_infos
      # @return [String]
      def build_src_set(asset_meta_infos)
        src_set = asset_meta_infos.map do |meta_info|
          "${#{meta_info.normalised_path}} #{meta_info.descriptor}"
        end.join(',')
        "`#{src_set}`"
      end
    end
  end
end
