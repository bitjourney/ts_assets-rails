require 'spec_helper'

RSpec.describe TsAssets::Generators::ReactGenerator do
  let(:mapping) { TsAssets::ApplicationGenerator.new(include: include_path).build_mapping(include_path) }
  let(:generator) { TsAssets::Generators::ReactGenerator.new(mapping) }

  let(:include_path) { 'spec/assets/images' }
  let(:environment) { Sprockets::Environment.new }

  before do
    environment.append_path(include_path)
  end

  describe '#generate' do
    it do
      content = generator.generate

      expected_header = "import * as React from 'react';"

      expected_body = <<~TS
      /** svg/ruby-icon */
      export function ImageSvgRubyIcon(props: any) {
          return <img alt="ruby-icon"
                      width={128}
                      src={PATH_SVG_RUBY_ICON}
                      srcSet={`${PATH_SVG_RUBY_ICON} 1x`}
                      {...props}
                      />;
      }

      /** webhook/slack_icon */
      export function ImageWebhookSlackIcon(props: any) {
          return <img alt="slack_icon"
                      width={20}
                      src={PATH_WEBHOOK_SLACK_ICON_1X}
                      srcSet={`${PATH_WEBHOOK_SLACK_ICON_1X} 1x,${PATH_WEBHOOK_SLACK_ICON_2X} 2x`}
                      {...props}
                      />;
      }
      TS

      expect(content.header).to eq expected_header
      expect(content.body).to eq expected_body
    end
  end

  describe '#merge_mapping_with_same_descriptors' do
    it "merge mapping's meta_infos into the same key" do
      actual = generator.send(:merge_mapping_with_same_descriptors, mapping)

      expect(actual.has_key?("svg/ruby-icon")).to eq true

      expect(actual.has_key?("webhook/slack_icon")).to eq true
      expect(actual.has_key?("webhook/slack_icon@1x")).to eq false
      expect(actual.has_key?("webhook/slack_icon@2x")).to eq false
    end

    it "merge mapping's meta_infos into an array with properate length" do
      actual = generator.send(:merge_mapping_with_same_descriptors, mapping)

      expect(actual["svg/ruby-icon"].length).to eq 1
      expect(actual["webhook/slack_icon"].length).to eq 2
    end
  end

  describe '#reactify' do
    it do
      asset_meta_infos = [
        TsAssets::Models::AssetMetaInfo.new(full_path: "#{include_path}/svg/ruby-icon.svg", environment: environment, include_path: include_path),
      ]
      expected = <<~TS
        /** svg/ruby-icon */
        export function ImageSvgRubyIcon(props: any) {
            return <img alt="ruby-icon"
                        width={128}
                        src={PATH_SVG_RUBY_ICON}
                        srcSet={`${PATH_SVG_RUBY_ICON} 1x`}
                        {...props}
                        />;
        }
      TS
      expect(generator.send(:reactify, 'svg/ruby-icon', asset_meta_infos)).to eq expected
    end
  end

  describe '#build_component_name' do
    it do
      expect(generator.send(:build_component_name, "svg/ruby-icon")).to eq "ImageSvgRubyIcon"
    end
  end

  describe '#build_src_set' do
    it do
      asset_meta_infos = [
        TsAssets::Models::AssetMetaInfo.new(full_path: "#{include_path}/webhook/slack_icon@1x.png", environment: environment, include_path: include_path),
        TsAssets::Models::AssetMetaInfo.new(full_path: "#{include_path}/webhook/slack_icon@2x.png", environment: environment, include_path: include_path),
      ]
      expect(generator.send(:build_src_set, asset_meta_infos)).to eq "`${PATH_WEBHOOK_SLACK_ICON_1X} 1x,${PATH_WEBHOOK_SLACK_ICON_2X} 2x`"
    end
  end
end
