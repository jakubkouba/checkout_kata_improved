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
      if item_price_rules.has_key?(:special_price)
        if count == item_price_rules[:special_price][:count]
          total += item_price_rules[:special_price][:price]
        elsif count < item_price_rules[:special_price][:count]
          total += count * item_price_rules[:unit_price]
        elsif count > item_price_rules[:special_price][:count]
          special_price_applied_times = count / item_price_rules[:special_price][:count]
          unit_price_applied_times = count % item_price_rules[:special_price][:count]
          total += (special_price_applied_times * item_price_rules[:special_price][:price]) + (unit_price_applied_times * item_price_rules[:unit_price])
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
