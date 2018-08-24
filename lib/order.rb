class Order

  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_status_list = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError, "Invalid fulfillment status." if !valid_status_list.include? @fulfillment_status
  end

  def total
    total = @products.sum {|k,v| v}
    total *= 1.075
    total.round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError, "Product already in product list." if @products.include? product_name
    @products[product_name] = price
  end

  def remove_product(product_name)
    raise ArgumentError, "Product does not exist." if !@products.include? product_name
    @products.delete(product_name)
  end

end

#test = Order.new(2452, {"apples" => 1}, "Anna", :blah)

#
# products = { "banana" => 1.99, "cracker" => 3.00 }
#
# order = Order.new(1337, products, "x")
# puts order.products
# order.remove_product("cracker")
# puts order.products
