# require 'pry'
#
# require_relative 'customer.rb'
#

class Order

attr_reader :id
attr_accessor :products, :customer, :fulfillment_status

FULLFILLMENT_STATUS = [:pending, :paid, :processing, :shipped, :complete]

def initialize (id, products, customer, status = :pending)
if FULLFILLMENT_STATUS.include?(status) == false
  return raise ArgumentError, 'Not a status'
end
  @id = id
  @products = products
  @customer = customer
  @fulfillment_status = status

end

def add_product
end

def order_total
end

end

# address = {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# }
# customer = Customer.new(123, "a@a.co", address)
#
# id = 1337
# fulfillment_status = :shipped
# products = {"banana" => 1.99, "cracker" => 3.00}
# order = Order.new(id, products, customer, fulfillment_status)
#
# binding.pry
