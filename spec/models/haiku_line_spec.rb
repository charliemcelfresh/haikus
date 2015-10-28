require 'rails_helper'

RSpec.describe HaikuLine, type: :model do
  let(:haiku) { FactoryGirl.create(:haiku, {"lines_attributes": {"0": {"content": "haiku line"}}} ) }
  it "should have a line number" do
    expect(haiku.lines.first.line_number).to eq(1)
    line_2 = haiku.lines.create({content: "Second line"})
    expect(line_2.line_number).to eq(2)
  end
end
