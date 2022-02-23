class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"

      case item.name
      when "Sulfuras, Hand of Ragnaros"
        item.quality = item.quality
      when "Aged Brie"
        item.quality += 1 unless item.quality == 50
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in < 0
          item.quality = 0
        else
          if item.quality != 50
            if item.sell_in <= 5
              item.quality += 3
            elsif item.sell_in <= 10
              item.quality += 2
            else
              item.quality += 1
            end
          end
        end
      else
        if item.quality != 0
          item.sell_in >= 0 ? item.quality -= 1 : item.quality -= 2
        end
      end
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