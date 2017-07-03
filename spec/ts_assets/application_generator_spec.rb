require 'spec_helper'

RSpec.describe TsAssets::ApplicationGenerator do
  let(:include_path) { 'spec/assets/images' }
  let(:generator) { TsAssets::ApplicationGenerator.new(include: include_path) }

  describe '#generate' do
    it { expect(generator.generate.length).to be > 0 }
  end
end
