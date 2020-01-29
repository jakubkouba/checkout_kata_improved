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
      product = Product.new(item_price_rules[:unit_price], item_price_rules[:special_price])
      total += if product.discount?
                 product.apply_discount(count)
               else
                 count * product.value
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

class Product

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

  def apply_discount(count)
    if count < discounted_amount
      count * value
    else
      discounted_price = (count / discounted_amount) * self.discounted_price
      price_for_single_units = (count % discounted_amount) * value
      discounted_price + price_for_single_units
    end
  end

end
