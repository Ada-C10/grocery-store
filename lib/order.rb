require 'pry'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status


  def initialize(id, product_hash, customer, fulfillment_status = :pending)
    @id = id
    @products = product_hash
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid_statuses = %i[pending paid processing shipped complete]

    unless valid_statuses.include?(@fulfillment_status)
      raise ArgumentError, 'Not a valid order'
    end
  end

  def total
    sum = @product.values.sum
    return (sum*1.075).round(2)
  end

  def add_product(name, price)
    if @product.each_key == name
      raise ArgumentError, 'This product already exists in order!'
    end
    return @product.merge!(name => price)
  end

end
#

# order = Order.new(1337, {}, 'customer', fulfillment_status: :shipped)
# products = { "banana" => 1.99, "cracker" => 3.00 }
# my_order = Order.new(3332, products, 'customer A')
# # my_order.add_product("coffee", 2.99)
#
# binding.pry
