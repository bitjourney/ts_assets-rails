
module TsAssets
  module Models
    class Content
      # [String]
      attr_reader :header

      # [String]
      attr_reader :body

      def initialize(header:, body:)
        @header = header
        @body = body
      end
    end
  end
end
