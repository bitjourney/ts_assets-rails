require 'fastimage'

module TsAssets
  module Models
    class AssetMetaInfo
      # [String]
      DESCRIPTOR_REGEX = /(.+?)@(\dx)./

      # full_path is a path from the app root.
      # ex) "app/assets/images/path/to/the/image.png"
      # @return [String]
      attr_reader :full_path

      # include_path is the app asset path root.
      # ex) "app/assets/images"
      # @return [String]
      attr_reader :include_path

      # @return [Sprockets::Environment]
      attr_reader :environment

      # @return [String]
      attr_reader :asset_path_without_descriptor

      # @return [String]
      attr_reader :descriptor

      # @return [Numeric]
      attr_reader :width

      # @return [Numeric]
      attr_reader :height

      # @param [String] full_path
      # @param [String] include_path
      # @param [Sprockets::Environment] environment
      def initialize(full_path:,
                     include_path:,
                     environment:)

        @full_path = full_path
        @include_path = include_path
        @environment = environment

        @width, @height = FastImage.size(full_path)

        if has_descriptor?
          # ex)
          #   dir/blog_feed.png -> #<MatchData "dir/blog_feed." 1:"dir/blog_feed">
          #   dir/blog_feed@2x.png -> #<MatchData "dir/blog_feed@2x." 1:"dir/blog_feed" 2:"2x">
          match_data = asset_path.match(DESCRIPTOR_REGEX)
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
        full_path.gsub(%r{^#{include_path}/}, '')
      end

      # @return [String]
      def asset_path_without_ext
        asset_path.chomp(File.extname(asset_path))
      end

      # @return [String]
      def digest_path
        environment.find_asset(asset_path).digest_path
      end

      # @return [String]
      def normalised_path
        "PATH_#{asset_path_without_ext.gsub(/[^a-zA-Z0-9_]/, '_').upcase}"
      end
    end
  end
end
