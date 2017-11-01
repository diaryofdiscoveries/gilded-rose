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
