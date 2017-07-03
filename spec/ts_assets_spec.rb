require "spec_helper"

RSpec.describe TsAssets do
  it "has a version number" do
    expect(TsAssets::VERSION).not_to be nil
  end
end
