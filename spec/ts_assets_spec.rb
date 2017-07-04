require 'spec_helper'

RSpec.describe TsAssets do
  let(:include_path) { 'spec/assets/images' }
  
  describe '.generate' do
    before do
      system("bundle exec rake generate")
    end

    it 'should generate a file content as a String' do
      source = TsAssets.generate(include: include_path)
      expect(source).to eq File.open("#{__dir__}/build/assets.tsx").read
    end
  end
end
