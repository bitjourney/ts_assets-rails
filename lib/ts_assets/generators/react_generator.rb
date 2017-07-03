module TsAssets
  module Generators
    class ReactGenerator < TsAssets::ApplicationGenerator
      attr_reader :mapping

      def initialize(mapping)
        @mapping = merge_mapping_with_same_descriptors(mapping)
      end

      def generate
        components = mapping.map { |path, asset_meta_infos| reactify(path, asset_meta_infos) }
        TsAssets::Models::Content.new(header: header, body: components.join("\n"))
      end

      private

      # Join AssetMetaInfo with same descriptors(e.g. x@1x.png & x@2x.png => )
      # @param [Hash<String, AssetMetaInfo>] mapping
      # @return [Hash<String, [AssetMetaInfo]>]
      def merge_mapping_with_same_descriptors(mapping)
        # key: path_without_descriptor
        # val: [AssetMetaInfo]
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

      def header
        "import * as React from 'react';"
      end

      # @param [String] path
      # @param [Array<AssetMetaInfo>] meta infos
      # @return [String] a code block in .tsx
      def reactify(path, asset_meta_infos)
        component_name = build_component_name(path)

        alt = File.basename(path)
        width = asset_meta_infos.first.width
        src = asset_meta_infos.first.normalised_path
        src_set = build_src_set(asset_meta_infos)

        <<~TS
          /** #{path} */
          export function #{component_name}(props: any) {
              return <img alt="#{alt}"
                          width={#{width}}
                          src={#{src}}
                          srcSet={#{src_set}}
                          {...props}
                          />;
          }
        TS
      end

      # @param [String] path
      # @return [String] component name
      def build_component_name(path)
        invalid_chars = %r{[@_/-]}
        normalised_name = path.split(invalid_chars).map(&:capitalize).join
        "Image#{normalised_name}"
      end

      # @param [Array<AssetMetaInfo>] asset meta infos
      def build_src_set(asset_meta_infos)
        src_set = asset_meta_infos.map do |meta_info|
          "${#{meta_info.normalised_path}} #{meta_info.descriptor}"
        end.join(',')
        "`#{src_set}`"
      end
    end
  end
end
