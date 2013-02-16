class Pricing
  attr_reader :unit_price, :quantity_rules

  def initialize price, quantity_rules = nil
    @unit_price = price
    @quantity_rules = Hash[quantity_rules] if quantity_rules
  end

  def calculate qty
    (0..qty).inject do |total,qty|
      if quantity_has_rules? qty
        rule = quantity_rules.to_a.select{|rule| qty % rule[0] == 0 }.last
        (qty * (rule[1].to_f/rule[0].to_f)).to_i
      else
        total + unit_price
      end
    end
  end

  private

  def quantity_has_rules? qty
    if !quantity_rules
      false
    elsif quantity_rules.find{|rule| qty % rule[0] == 0 }
      true
    end
  end
end