class Order
  attr_reader :id, :products, :customer, :fulfillment_status

# integer, hash, Class::Customer, symbol
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products # { "banana" => 1.99, "cracker" => 3.00 }
    @customer = customer
    @fulfillment_status = fulfillment_status

    @@valid_statuses = %i[pending paid processing shipped complete]
    unless @@valid_statuses.include?(@fulfillment_status)
      raise ArgumentError, ":fulfillment_status is invalid. Try: " \
                           "[:pending (default), :paid, :processing, " \
                           ":shipped, :complete]"
    end
  end

  def total
# calculate total cost of order from @products hash
    subtotal = @products.values.sum
    return total = (subtotal*1.075).round(2)
  end

# string, float/integer
  def add_product(product_name, price)

    if @products.keys.include?(product_name)
      raise ArgumentError, "Your order already has a product with this name."
    end

    return @products[product_name] = price
  end

  def remove_product(product_name)
    unless @products.keys.include?(product_name)
      raise ArgumentError, "There isn't a product with that name in your order."
    end

    return @products.delete(product_name)
  end
end
