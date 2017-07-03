require 'spec_helper'

RSpec.describe TsAssets::Models::AssetMetaInfo do
  let(:full_path) { 'app/assets/images/4xx.svg' }
  let(:full_path_1x) { 'app/assets/images/webhook/slack_icon@1x.png' }
  let(:full_path_2x) { 'app/assets/images/webhook/slack_icon@2x.png' }

  let(:asset_meta_info) { TsAssets::Models::AssetMetaInfo.new(full_path: full_path) }
  let(:asset_meta_info_1x) { TsAssets::Models::AssetMetaInfo.new(full_path: full_path_1x) }
  let(:asset_meta_info_2x) { TsAssets::Models::AssetMetaInfo.new(full_path: full_path_2x) }

  describe '#has_descriptor?' do
    it {
      expect(asset_meta_info.has_descriptor?).to eq false
      expect(asset_meta_info_1x.has_descriptor?).to eq true
      expect(asset_meta_info_2x.has_descriptor?).to eq true
    }
  end

  describe '#descriptor' do
    it {
      expect(asset_meta_info.descriptor).to eq '1x' # set default
      expect(asset_meta_info_1x.descriptor).to eq '1x'
      expect(asset_meta_info_2x.descriptor).to eq '2x'
    }
  end

  describe '#asset_path' do
    it {
      expect(asset_meta_info.asset_path).to eq '4xx.svg'
      expect(asset_meta_info_1x.asset_path).to eq 'webhook/slack_icon@1x.png'
      expect(asset_meta_info_2x.asset_path).to eq 'webhook/slack_icon@2x.png'
    }
  end

  describe '#asset_path_without_descriptor' do
    it {
      expect(asset_meta_info.asset_path_without_descriptor).to eq '4xx'
      expect(asset_meta_info_1x.asset_path_without_descriptor).to eq 'webhook/slack_icon'
      expect(asset_meta_info_2x.asset_path_without_descriptor).to eq 'webhook/slack_icon'
    }
  end

  describe '#asset_path_without_ext' do
    it {
      expect(asset_meta_info.asset_path_without_ext).to eq '4xx'
      expect(asset_meta_info_1x.asset_path_without_ext).to eq 'webhook/slack_icon@1x'
      expect(asset_meta_info_2x.asset_path_without_ext).to eq 'webhook/slack_icon@2x'
    }
  end

  # TODO: these test requires the exect file in the app/assets/images folder
  describe '#width' do
    it {
      expect(asset_meta_info.width).to eq 208
      expect(asset_meta_info_1x.width).to eq 20
      expect(asset_meta_info_2x.width).to eq 40
    }
  end

  # TODO: these test requires the exect file in the app/assets/images folder
  describe '#height' do
    it {
      expect(asset_meta_info.height).to eq 154
      expect(asset_meta_info_1x.height).to eq 20
      expect(asset_meta_info_2x.height).to eq 40
    }
  end

  # TODO: these test requires the exect file in the app/assets/images folder
  describe '#digest_path' do
    it {
      expect(asset_meta_info.digest_path).to match(/^4xx-(.+).svg$/)
      expect(asset_meta_info_1x.digest_path).to match %r{^webhook/slack_icon@1x-(.+).png}
      expect(asset_meta_info_2x.digest_path).to match %r{^webhook/slack_icon@2x-(.+).png}
    }
  end

  describe '#normalised_path' do
    it {
      expect(asset_meta_info.normalised_path).to eq 'PATH_4XX'
      expect(asset_meta_info_1x.normalised_path).to eq 'PATH_WEBHOOK_SLACK_ICON_1X'
      expect(asset_meta_info_2x.normalised_path).to eq 'PATH_WEBHOOK_SLACK_ICON_2X'
    }
  end
end
