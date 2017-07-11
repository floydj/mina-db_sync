require "spec_helper"

RSpec.describe Mina::DbSync do
  it "has a version number" do
    expect(Mina::DbSync::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
