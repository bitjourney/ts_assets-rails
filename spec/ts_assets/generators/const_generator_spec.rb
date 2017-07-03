require 'spec_helper'

RSpec.describe TsAssets::Generators::ConstGenerator do
  let(:mapping) { TsAssets::ApplicationGenerator.new(include: include_path).build_mapping(include_path) }
  let(:generator) { TsAssets::Generators::ConstGenerator.new(mapping) }

  let(:include_path) { 'spec/assets/images' }
  let(:environment) { Sprockets::Environment.new }

  before do
    environment.append_path(include_path)
  end

  describe '#generate' do
    it do
      content = generator.generate

      expected_body = <<~TS
      /** svg/ruby-icon.svg */
      const PATH_SVG_RUBY_ICON = "/assets/svg/ruby-icon-486fbe77b2fa535451a48ccd48587f8a1359fb373b7843e14fb5a84cb2697160.svg";

      /** webhook/slack_icon@1x.png */
      const PATH_WEBHOOK_SLACK_ICON_1X = "/assets/webhook/slack_icon@1x-dd316f78fb005e28fb960482d5972fc58ab33da6836c684c1b61e7cb1b60d1e0.png";

      /** webhook/slack_icon@2x.png */
      const PATH_WEBHOOK_SLACK_ICON_2X = "/assets/webhook/slack_icon@2x-4f5daeae796f89bb5590bae233226cacd092c1c4e911a12061bfe12c597cc885.png";
      TS

      expect(content.header).to eq nil
      expect(content.body).to eq expected_body
    end
  end

  describe '#constify' do
    it do
      asset_meta_info = TsAssets::Models::AssetMetaInfo.new(full_path: "#{include_path}/svg/ruby-icon.svg", environment: environment, include_path: include_path)
      expected = <<~TS
        /** svg/ruby-icon.svg */
        const PATH_SVG_RUBY_ICON = "/assets/svg/ruby-icon-486fbe77b2fa535451a48ccd48587f8a1359fb373b7843e14fb5a84cb2697160.svg";
      TS
      expect(generator.send(:constify, asset_meta_info)).to eq expected
    end
  end
end
