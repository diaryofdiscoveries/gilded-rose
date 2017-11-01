class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name

      when 'Aged Brie'
        AgedBrieUpdater.new(item).update
      when 'Sulfuras, Hand of Ragnaros'
        SulfurasUpdater.new(item).update
      when 'Backstage passes to a TAFKAL80ETC concert'
        BackstagePassesUpdater.new(item).update
      when 'Conjured'
        ConjuredUpdater.new(item).update
      else
        NormalUpdater.new(item).update
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

class ItemUpdater
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update
    update_quality
    update_sell_in
  end

  private

  def update_quality
    # raise NotImplementedError
  end

  def update_sell_in
    # raise NotImplementedError
  end
end

class NormalUpdater < ItemUpdater
  private

  def update_quality
    quality = if item.sell_in > 0
                item.quality - 1
              else
                item.quality - 2
              end

    item.quality = quality if quality >= 0
  end

  def update_sell_in
    item.sell_in -= 1
  end
end

class AgedBrieUpdater < ItemUpdater
  private

  def update_quality
    quality = if item.sell_in > 0
                item.quality + 1
              else
                item.quality + 2
              end

    item.quality = quality if quality <= 50
    item.quality = 50 if quality > 50
  end

  def update_sell_in
    item.sell_in -= 1
  end
end

class SulfurasUpdater < ItemUpdater
end

class BackstagePassesUpdater < ItemUpdater
  private

  def update_quality
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
  end

  def update_sell_in
    item.sell_in -= 1
  end
end

class ConjuredUpdater < ItemUpdater
  private

  def update_quality
    quality = item.quality -= 2

    item.quality = quality if quality >= 0
    item.quality = 0 if quality < 0
  end

  def update_sell_in
    item.sell_in -= 1
  end
end
