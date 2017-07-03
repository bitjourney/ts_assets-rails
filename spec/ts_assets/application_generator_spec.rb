require 'spec_helper'

RSpec.describe TsAssets::ApplicationGenerator do
  describe 'ApplicationGenerator' do
    let(:generator) { TsAssets::ApplicationGenerator.new }

    describe '#generate' do
      it { expect(generator.generate.length).to be > 0 }
    end
  end
end
