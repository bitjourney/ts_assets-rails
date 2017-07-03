require 'fastimage'

module TsAssets
  module Models
    class AssetMetaInfo
      DESCRIPTOR_REGEX = /(.+?)@(\dx)./

      # full_path is a path from the app root.
      # ex) "app/assets/images/path/to/the/image.png"
      # [String]
      attr_reader :full_path

      # include_path is the app asset path root.
      # ex) "app/assets/images"
      # [String]
      attr_reader :include_path

      # [Sprockets::Environment]
      attr_reader :environment

      # [String]
      attr_reader :asset_path_without_descriptor

      # [String]
      attr_reader :descriptor

      # [number]
      attr_reader :width

      # [number]
      attr_reader :height

      # @param [String] full_path
      def initialize(full_path:, 
                     include_path:,
                     environment:
                     )

        @full_path = full_path
        @include_path = include_path
        @environment = environment

        @width, @height = FastImage.size(full_path)

        if has_descriptor?
          # dir/blog_feed.png -> #<MatchData "dir/blog_feed." 1:"dir/blog_feed">
          # dir/blog_feed@2x.png -> #<MatchData "dir/blog_feed@2x." 1:"dir/blog_feed" 2:"2x">
          match_data = asset_path.match(DESCRIPTOR_REGEX)
          # dir/blog_feed, 2x
          @asset_path_without_descriptor, @descriptor = match_data.captures
        else
          @asset_path_without_descriptor = asset_path_without_ext
          @descriptor = '1x' # 1x as a default descriptor
        end
      end

      # @return [Boolean]
      def has_descriptor?
        !asset_path.match(DESCRIPTOR_REGEX).nil?
      end

      # @return [String]
      def asset_path
        # ex) "emptystate/en/blog_feed@2x.png"
        full_path.gsub(%r{^#{include_path}/}, '')
      end

      # @return [String] asset path_without_ext
      def asset_path_without_ext
        asset_path.chomp(File.extname(asset_path))
      end

      # @return [String]
      def digest_path
        # ex) "emptystate/ja/blog_feed@2x-96cf00af98b2380dc6ad9cb4415e8e856781ec0747d22245804c602c50005956.png"
        # Rails.application.assets.find_asset(asset_path).digest_path
        environment.find_asset(asset_path).digest_path
      end

      # ex) "toast/success.svg" -> PATH_TOAST_SUCCESS
      # @param [String] path
      # @return [String] normalised path
      def normalised_path
        invalid_chars = %r{[/.@-]}
        "PATH_#{asset_path_without_ext.gsub(invalid_chars, '_').upcase}"
      end
    end
  end
end
