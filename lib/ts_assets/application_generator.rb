require 'sprockets'

module TsAssets
  class ApplicationGenerator
    # @return [Hash] mapping
    attr_reader :mapping

    # @param [String] include
    def initialize(include:)
      @mapping = build_mapping(include)

      environment.append_path(include)
    end

    # @return [Sprockets::Environment]
    def environment
      @environment ||= Sprockets::Environment.new
    end

    # @return [String]
    def generate
      [ # header
        react_content.header,

        # body
        const_content.body,
        react_content.body,

      ].join("\n")
    end

    # @return [TsAssets::Models::Content]
    def const_content
      @const_content ||= TsAssets::Generators::ConstGenerator.new(mapping).generate
    end

    # @return [TsAssets::Models::Content]
    def react_content
      @react_content ||= TsAssets::Generators::ReactGenerator.new(mapping).generate
    end

    # @param [String] include_path
    # @return [Hash]
    def build_mapping(include_path)
      mapping = {}

      Dir.glob("#{include_path}/**/*.{png,svg,jpg,jpeg,gif}").sort.each do |full_path|
        mapping[full_path] = TsAssets::Models::AssetMetaInfo.new(
          full_path: full_path,
          include_path: include_path,
          environment: environment,
        )
      end

      mapping
    end
  end
end
