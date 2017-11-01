class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name

      when 'Aged Brie'
        quality = if item.sell_in > 0
                    item.quality + 1
                  else
                    item.quality + 2
                  end

        item.quality = quality if quality <= 50
        item.quality = 50 if quality > 50
        item.sell_in -= 1

        return

      when 'Sulfuras, Hand of Ragnaros'

        return

      when 'Backstage passes to a TAFKAL80ETC concert'
        if item.sell_in > 10
          quality = item.quality += 1
        elsif item.sell_in > 5
          quality = item.quality += 2
        elsif item.sell_in > 0
          quality = item.quality += 3
        elsif
          quality = item.quality = 0
        end

        item.quality = 50 if quality > 50
        item.sell_in -= 1

        return

      else
        quality = if item.sell_in > 0
                    item.quality - 1
                  else
                    item.quality - 2
                  end

        item.quality = quality if quality >= 0

        item.sell_in -= 1

        return

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

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
