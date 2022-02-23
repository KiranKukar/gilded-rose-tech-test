require 'gilded_rose'

describe GildedRose do
  describe ".update_quality()" do
    let(:item_aged_brie) { Item.new("Aged Brie",40,20) }
    let(:item_sulfuras) { Item.new("Sulfuras, Hand of Ragnaros",0,30) }
    let(:item_backstage_pass) { Item.new("Backstage passes to a TAFKAL80ETC concert",40,2) }
    let(:item_no_sell_in) { Item.new("Blue Herb",0,10) }

    before(:each) do
      @gilded_rose = GildedRose.new([item_aged_brie, item_sulfuras, item_backstage_pass, item_no_sell_in])
    end

    it "Once the sell by date has passed, Quality degrades twice as fast" do
      expect { @gilded_rose.update_quality }.to change(item_no_sell_in, :quality).by(-2)
    end

    it "aged brie,backstage passes and undefined items, all decrease sell_in by one " do
      expect { @gilded_rose.update_quality }.to change(item_aged_brie, :sell_in).by(-1)
      expect { @gilded_rose.update_quality }.to change(item_backstage_pass, :sell_in).by(-1)
      expect { @gilded_rose.update_quality }.to change(item_no_sell_in, :sell_in).by(-1)
    end

    it "The Quality of an item is never negative" do
      6.times { @gilded_rose.update_quality }
      expect(item_no_sell_in.quality).to eq 0
    end

    it "“Aged Brie” increases in Quality the older it gets" do
      expect { @gilded_rose.update_quality }.to change(item_aged_brie, :quality).by(1)
    end

    it "The Quality of an item is never more than 50" do
      31.times { @gilded_rose.update_quality }
      expect(item_aged_brie.quality).to eq 50
    end

    it "“Sulfuras” never has to be sold or decreases in Quality" do
      expect { @gilded_rose.update_quality }.not_to change(item_sulfuras, :quality)
      expect { @gilded_rose.update_quality }.not_to change(item_sulfuras, :sell_in)
    end

    it "“Backstage passes” increases in Quality as sell-in value approaches" do
      expect { @gilded_rose.update_quality }.to change(item_backstage_pass, :quality).by(1)
    end

    it "“Backstage passes” increases in Quality increases by 2 when there are 10 days or less to sell_in" do
      30.times { @gilded_rose.update_quality }
      expect { @gilded_rose.update_quality }.to change(item_backstage_pass, :quality).by(2)
    end

    it "“Backstage passes” increases in Quality increases by 3 when there are 5 days or less to sell_in" do
      35.times { @gilded_rose.update_quality }
      expect { @gilded_rose.update_quality }.to change(item_backstage_pass, :quality).by(3)
    end

    it "“Backstage passes” Quality drops to 0 after the concert" do
      41.times { @gilded_rose.update_quality }
      expect(item_backstage_pass.quality).to eq 0
    end

# “Conjured” items degrade in Quality twice as fast as normal items

  end
end