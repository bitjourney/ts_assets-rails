require 'sprockets'

module TsAssets
  class ApplicationGenerator
    DEFAULT_FILE_HEADER = "/* tslint:disable */"

    # [Hash]
    attr_reader :mapping

    def initialize(include:)
      @mapping = build_mapping(include)

      environment.append_path(include)
    end

    def environment
      @environment ||= Sprockets::Environment.new
    end

    # @return [String] assets.ts content as a text
    def generate
      [ # header
        DEFAULT_FILE_HEADER,
        react_content.header,

        # body
        const_content.body,
        react_content.body,

      ].join("\n\n")
    end

    def const_content
      @const_content ||= TsAssets::Generators::ConstGenerator.new(mapping).generate
    end

    def react_content
      @react_content ||= TsAssets::Generators::ReactGenerator.new(mapping).generate
    end

    # @param [String]
    # @return [Hash]
    def build_mapping(include_path)
      mapping = {}

      Dir.glob("#{include_path}/**/*.*").map do |full_path|
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
