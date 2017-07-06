
module TsAssets
  module Models
    class Content
      # @return [String]
      attr_reader :header

      # @return [String]
      attr_reader :body

      # @param [String] header
      # @param [String] body
      def initialize(header:, body:)
        @header = header
        @body = body
      end
    end
  end
end
