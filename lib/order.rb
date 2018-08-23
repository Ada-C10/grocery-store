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
    # sum up products
    # add 7.5% tax
    # round to two decimal places
  end

  def add_product(product_name, price)
    # add data to product collection
    # raise error if product with same name is already on order
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
