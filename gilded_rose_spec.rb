require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'rspec'
require 'rspec/autorun'

RSpec::Matchers.define :update_to do |sell_in, quality|
  match do |item|
      new_item = update(actual)
      expect(new_item.sell_in).to eq sell_in
      expect(new_item.quality).to eq quality
  end
  failure_message_for_should do |actual|
    new_item = update(actual)
    "Expected #{actual} to end up with sell_in=#{sell_in} and quality=#{quality}. Got #{new_item}."
  end

  def update(item)
      cloned_item = item.clone
      GildedRose.new([cloned_item]).update_quality
      cloned_item
  end
end

describe GildedRose do
  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end

    it "decreases the quality of an in-date item by 1" do
      expect(Item.new("foo", 10, 10)).to update_to 9,9
    end

    it "decreases the quality of an out-of-date item by 2" do
      expect(Item.new("foo", 0, 10)).to update_to -1,8
    end

    it "does not drop quality below 0" do
      expect(Item.new("foo", 0, 0)).to update_to -1,0
    end

    it "does not decrease the quality or sell by of sulfuras" do
      expect(Item.new("Sulfuras, Hand of Ragnaros", 10, 10)).to update_to 10,10
    end

    it "increases the quality of in-date aged brie" do
      expect(Item.new("Aged Brie", 10, 10)).to update_to 9,11
    end

    it "rapidly increases the quality of out-of-date aged brie" do
      expect(Item.new("Aged Brie", 0, 10)).to update_to -1, 12
    end

    it "does not increase the quality of any item over 50" do
      items = [Item.new("Aged Brie", 10, 50), Item.new("Aged Brie", 0, 49), Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 49)]
      GildedRose.new(items).update_quality
      items.each do |item|
        expect(item.quality).to eq 50
      end
    end

    it "increases the quality of a backstage pass more than 10 days before its sell by date" do
      expect(Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)).to update_to 10,11
    end

    it "rapidly increases the quality of a backstage pass between 6 and 10 days before its sell by date" do
      expect(Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)).to update_to 9,12
      expect(Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 10)).to update_to 5,12
    end

    it "very rapidly increases the quality of a backstage pass between 1 and 5 days before its sell by date" do
      expect(Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)).to update_to 4,13
      expect(Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 10)).to update_to 0,13
    end

    it "drops the quality of a backstage pass to 0 beyond its sell by date" do
      expect(Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)).to update_to -1,0
      expect(Item.new("Backstage passes to a TAFKAL80ETC concert", -3, 10)).to update_to -4,0
    end

  end

end
