require_relative 'item'
require_relative 'item_updater'
require_relative 'normal_updater'
require_relative 'aged_brie_updater'
require_relative 'sulfuras_updater'
require_relative 'backstage_passes_updater'
require_relative 'conjured_updater'

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
