class Order < Sequel::Model(:Orders)
  # Returns a hash of coffee name => total units sold across all orders
  def self.coffees_by_type
    counts = Hash.new(0)

    OrderItem.all.each do |item|
      product = Products[item.product_id]
      next unless product && product.product_type == 1

      counts[product.name] += item.qty
    end

    counts
  end

  # Returns a hash of "Origin - Roast Level" => total units sold across all orders
  def self.beans_by_type
    counts = Hash.new(0)

    OrderItem.all.each do |item|
      product = Products[item.product_id]
      next unless product && product.product_type == 0

      bean = Beans[item.product_id]
      next unless bean

      key = "#{bean.origin} - #{bean.roast_level}"
      counts[key] += item.qty
    end

    counts
  end

  # Returns the total number of free coffees redeemed
  # Found in OrderItems - number of free coffees per item
  def self.free_coffees_redeemed
    freeDrinks = 0

    OrderItems.all.each do |order|
      freeDrinks += order.free_items
    end

    freeDrinks
  end
end
