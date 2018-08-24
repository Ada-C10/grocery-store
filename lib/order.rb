require_relative 'customer'
require 'pry'

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    if valid_status.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, 'Fulfillment status is not valid'
    end
  end

  def total
    subtotal = @products.sum { |product_name, price| price }
    return total_cost = (subtotal * 1.075).round(2)
  end

  def add_product(product_name, price)
    if @products.keys.include?(product_name)
      raise ArgumentError, 'Product has already been added to the order'
    else
      return @products[product_name] = price
    end
  end

  def remove_product(product_name)
    if @products.keys.include?(product_name)
      return @products.reject! { |k| k == product_name }
    else
      raise ArgumentError, 'No product with that name exists in the current order'
    end
  end

end
# address = {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# }
# customer = Customer.new(123, "a@a.co", address)
# id = 1337
# fulfillment_status = :shipped
# order = Order.new(id, {}, customer, fulfillment_status)
# binding.pry
