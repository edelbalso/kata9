class Item

  attr_reader :quantity, :sku

  def initialize sku, priceing = nil
    @sku = sku
    @priceing = priceing
    @quantity = 0
  end

  def increment
    @quantity += 1
  end

  def total
    @priceing.calculate quantity
  end


end