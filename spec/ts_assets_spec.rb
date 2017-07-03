require 'spec_helper'

RSpec.describe TsAssets do
  describe '.generate' do
    it 'should generate a file content as a String' do
      source = TsAssets.generate
      expect(source.length).to be > 0
    end
  end
end
