class Checkout

  attr_reader :items

  def initialize(price_rules)
    @price_rules = price_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    0
  end
end
