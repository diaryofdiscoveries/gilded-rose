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
