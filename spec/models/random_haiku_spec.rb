require 'rails_helper'

RSpec.describe RandomHaiku, type: :model do
  it "should not create haiku if not enough lines" do
    h = FactoryGirl.build(:haiku)
    lines = [{content: "first line"}, {content: "Second line"}, {content: "third line"}]
    h.lines.build(lines)
    h.save
    expect(RandomHaiku.create).to_not be_valid
  end

  it "should not create duplicate haikus" do
    h = FactoryGirl.build(:haiku)
    lines = [{content: "first line"}, {content: "Second line"}, {content: "third line"}]
    h.lines.build(lines)
    h.save
    r = RandomHaiku.new
    h.lines.each do |l|
      r.lines << l
    end
    expect(r.save).to be_falsey
    
  end
end
