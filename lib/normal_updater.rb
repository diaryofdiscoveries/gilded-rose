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
