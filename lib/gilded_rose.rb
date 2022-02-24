class GildedRose

  def initialize(items)
    @items = items
  end

  def item_sell_in_update(item)
    item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
  end

  def aged_brie_quality_update(item)
    item.quality += 1 unless item.quality == 50
  end

  def backstage_pass_quality_update(item)
    if item.sell_in.negative?
      item.quality = 0
    elsif item.quality != 50
      if item.sell_in <= 5
        item.quality += 3
      elsif item.sell_in <= 10
        item.quality += 2
      else
        item.quality += 1
      end
    end
  end

  def conjured_quality_update(item)
    return if item.quality.zero?
    item.sell_in >= 0 ? item.quality -= 2 : item.quality -= 4
  end

  def other_item_quality_update(item)
    return if item.quality.zero?
    item.sell_in >= 0 ? item.quality -= 1 : item.quality -= 2
  end

  def item_name_quality_update(item)
    case item.name
    when "Sulfuras, Hand of Ragnaros"; return
    when "Aged Brie"; aged_brie_quality_update(item)
    when "Backstage passes to a TAFKAL80ETC concert"; backstage_pass_quality_update(item)
    when "Conjured"; conjured_quality_update(item)
    else
      other_item_quality_update(item)
    end
  end

  def update_quality
    @items.each do |item|
      item_sell_in_update(item)
      item_name_quality_update(item)
    end
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
