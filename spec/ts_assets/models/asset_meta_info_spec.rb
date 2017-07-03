require 'spec_helper'
require 'sprockets'

RSpec.describe TsAssets::Models::AssetMetaInfo do
  let(:include_path) { 'spec/assets/images' }
  let(:environment) { Sprockets::Environment.new }

  let(:full_path) { "#{include_path}/svg/ruby-icon.svg" }
  let(:full_path_1x) { "#{include_path}/webhook/slack_icon@1x.png" }
  let(:full_path_2x) { "#{include_path}/webhook/slack_icon@2x.png" }

  let(:asset_meta_info) { TsAssets::Models::AssetMetaInfo.new(full_path: full_path, environment: environment, include_path: include_path) }
  let(:asset_meta_info_1x) { TsAssets::Models::AssetMetaInfo.new(full_path: full_path_1x, environment: environment, include_path: include_path) }
  let(:asset_meta_info_2x) { TsAssets::Models::AssetMetaInfo.new(full_path: full_path_2x, environment: environment, include_path: include_path) }

  before do
    environment.append_path(include_path)
  end

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
      expect(asset_meta_info.asset_path).to eq 'svg/ruby-icon.svg'
      expect(asset_meta_info_1x.asset_path).to eq 'webhook/slack_icon@1x.png'
      expect(asset_meta_info_2x.asset_path).to eq 'webhook/slack_icon@2x.png'
    }
  end

  describe '#asset_path_without_descriptor' do
    it {
      expect(asset_meta_info.asset_path_without_descriptor).to eq 'svg/ruby-icon'
      expect(asset_meta_info_1x.asset_path_without_descriptor).to eq 'webhook/slack_icon'
      expect(asset_meta_info_2x.asset_path_without_descriptor).to eq 'webhook/slack_icon'
    }
  end

  describe '#asset_path_without_ext' do
    it {
      expect(asset_meta_info.asset_path_without_ext).to eq 'svg/ruby-icon'
      expect(asset_meta_info_1x.asset_path_without_ext).to eq 'webhook/slack_icon@1x'
      expect(asset_meta_info_2x.asset_path_without_ext).to eq 'webhook/slack_icon@2x'
    }
  end

  describe '#width' do
    it {
      expect(asset_meta_info.width).to eq 128
      expect(asset_meta_info_1x.width).to eq 20
      expect(asset_meta_info_2x.width).to eq 40
    }
  end

  describe '#height' do
    it {
      expect(asset_meta_info.height).to eq 128
      expect(asset_meta_info_1x.height).to eq 20
      expect(asset_meta_info_2x.height).to eq 40
    }
  end

  describe '#digest_path' do
    it {
      expect(asset_meta_info.digest_path).to match %r{^svg/ruby-icon-(.+).svg$}
      expect(asset_meta_info_1x.digest_path).to match %r{^webhook/slack_icon@1x-(.+).png}
      expect(asset_meta_info_2x.digest_path).to match %r{^webhook/slack_icon@2x-(.+).png}
    }
  end

  describe '#normalised_path' do
    it {
      expect(asset_meta_info.normalised_path).to eq 'PATH_SVG_RUBY_ICON'
      expect(asset_meta_info_1x.normalised_path).to eq 'PATH_WEBHOOK_SLACK_ICON_1X'
      expect(asset_meta_info_2x.normalised_path).to eq 'PATH_WEBHOOK_SLACK_ICON_2X'
    }
  end
end
