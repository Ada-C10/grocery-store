class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id # integer
    @products = products # { "banana" => 1.99, "cracker" => 3.00 }
    @customer = customer # Class::Customer
    @fulfillment_status = fulfillment_status

    @@valid_statuses = %i[pending paid processing shipped complete]
    unless @@valid_statuses.include?(@fulfillment_status)
      raise ArgumentError, "Fulfillment Status must be one of these, or blank: :pending (default), :paid, :processing, :shipped, :complete)"
    end
  end

  def total
# calculate total cost of order from @products hash
    subtotal = @products.values.sum
    return total = (subtotal*1.075).round(2)
  end

  def add_product(product_name, price)
# take 2 parameters
# add product to collection
# raise ArgumentError if the order already has a product with the same name
  end

end
