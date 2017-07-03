require 'spec_helper'

RSpec.describe TsAssets::ApplicationGenerator do
  describe 'ApplicationGenerator' do
    let(:mapping) { TsAssets::ApplicationGenerator.new.send(:build_mapping, 'app/assets/images') }
    let(:generator) { TsAssets::Generators::ConstGenerator.new(mapping) }

    describe '#constify' do
      it do
        asset_meta_info = TsAssets::Models::AssetMetaInfo.new(full_path: 'app/assets/images/toast/success.svg')
        expected = <<~TS
          /** toast/success.svg */
          const PATH_TOAST_SUCCESS = '/assets/toast/success-113d8c6567441218600adb7fd8a9cf2de8c877aa61df3c5cef9503e5b6d22e16.svg';
        TS
        expect(generator.send(:constify, asset_meta_info)).to eq expected
      end
    end
  end
end
