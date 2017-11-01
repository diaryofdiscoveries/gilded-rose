require_relative 'item_updater'
require_relative 'normal_updater'
require_relative 'aged_brie_updater'
require_relative 'sulfuras_updater'
require_relative 'backstage_passes_updater'
require_relative 'conjured_updater'

class Updaters
  attr_reader :item

  TYPE = {
    'Aged Brie'                                 => AgedBrieUpdater,
    'Sulfuras, Hand of Ragnaros'                => SulfurasUpdater,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePassesUpdater,
    'Conjured'                                  => ConjuredUpdater
  }.freeze

  def initialize(item)
    @item = item
  end

  def update
    updater.new(item).update
  end

  def self.update(item)
    new(item).update
  end

  private

  def updater
    @updater ||= TYPE[item.name] || NormalUpdater
  end
end
