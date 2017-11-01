require_relative 'item'
require_relative 'updaters'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      Updaters.update(item)
    end
  end
end
