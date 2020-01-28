class Checkout

  attr_reader :items, :price_rules

  def initialize(price_rules)
    @price_rules = price_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    return 0 if items.empty?

    items.reduce(0) do |total, item|
      item_price_rules = price_rules[item]
      total += item_price_rules[:unit_price]
      total
    end
  end
end
