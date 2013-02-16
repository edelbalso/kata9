class InvalidSkuError < StandardError ; end

class CheckOut

  attr_reader :items, :prices

  def initialize rules

    prices_array = rules.map do |sku,pricing_rule|
      [sku, priceify(pricing_rule)]
    end

    @allowed_skus = rules.keys

    @prices = Hash[prices_array]

    @items = []

  end

  def total
    items.inject(0){ |sum, item| sum + item.total }
  end

  def scan(sku)
    raise InvalidSkuError unless @allowed_skus.include? sku

    unless items.find{ |item| item.sku == sku }.try(:increment).present?
      item = Item.new(sku,prices[sku])
      item.increment
      items << item
    end
  end

  private

  def priceify rule
    if rule.class == Fixnum
      Pricing.new rule
    elsif rule.class == Hash
      Pricing.new rule[:price], rule[:quantity_pricings]
    end

  end
end
