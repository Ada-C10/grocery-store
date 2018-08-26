require_relative 'customer'

class Order
  attr_reader :id, :products

#fulfillment_status is set to :pending as a default
#id , products customer , fulfilment status, should be symbols?
# order = Order.new(id, {}, customer, fulfillment_status)

  def initialize(id, products, customer, fulfillment_status = :pending) #should id and ful_st be different?
    @id = id
    @products = {}
    @customer = customer #(should this be different?)
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError.new("hey, that is an invalid status") unless valid_status.include?(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end

#sum up products to calc total
#add 7.5% tax
#round to 2 decimal places
  def total
    @total = 0
    @products.each_value do |cost|
      @total += cost
    end
    @total += @total *= 0.075
    return @total.round(2)
  end
# An add_product method which will take in two parameters,
# product name and price, and add the data to the product collection
# If a product with the same name has already been
# added to the order, an ArgumentError should be raised
  def add_product(name, price)
    raise ArgumentError.new("woah! this product is already on the order") if products.has_key?(name)
    @products[name] = price
  end


end

# p new_order = Order.new(111, {"tea" => 5.5, "coffee" => 9}, "kay", fulfillment_status: :shipped)
# p new_order.total
# p new_order.add_product("water", 100)
# p new_order.products
# p new_order.add_product("water", 100)
