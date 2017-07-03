require 'spec_helper'

RSpec.describe TsAssets::ApplicationGenerator do
  describe 'ApplicationGenerator' do
    let(:mapping) { TsAssets::ApplicationGenerator.new.send(:build_mapping, 'app/assets/images') }
    let(:generator) { TsAssets::Generators::ReactGenerator.new(mapping) }

    describe '#reactify' do
      it do
        asset_meta_infos = [
          TsAssets::Models::AssetMetaInfo.new(full_path: 'app/assets/images/toast/success.svg'),
        ]
        expected = <<~TS
          /** toast/success */
          export function ImageToastSuccess(props: any) {
              return <img alt='success'
                          width={20}
                          src={PATH_TOAST_SUCCESS}
                          srcSet={`${PATH_TOAST_SUCCESS} 1x`}
                          {...props}
                          />;
          }
        TS
        expect(generator.send(:reactify, 'toast/success', asset_meta_infos)).to eq expected
      end
    end
  end
end
