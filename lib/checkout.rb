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

    items_with_count.reduce(0) do |total, (item,count)|
      item_price_rules = price_rules[item]
      unit_price = UnitPrice.new(item_price_rules[:unit_price], item_price_rules[:special_price])
      if unit_price.discount?
        if count == unit_price.discounted_amount
          total += unit_price.discounted_price
        elsif count < unit_price.discounted_amount
          total += count * unit_price.value
        elsif count > unit_price.discounted_amount
          special_price_applied_times = count / unit_price.discounted_amount
          unit_price_applied_times = count % unit_price.discounted_amount
          total += (special_price_applied_times * unit_price.discounted_price) + (unit_price_applied_times * unit_price.value)
        end
      else
        total += count * item_price_rules[:unit_price]
      end
      total
    end
  end

  private

  def items_with_count
    @items_count = items.inject(Hash.new(0)) do |items_count, item|
      items_count[item] += 1
      items_count
    end
  end
end

class UnitPrice

  attr_reader :value

  def initialize(price, discount)
    @value = price
    @discount = discount
  end

  def discount?
    !@discount.nil?
  end

  def discounted_amount
    @discount[:count]
  end

  def discounted_price
    @discount[:price]
  end

end
