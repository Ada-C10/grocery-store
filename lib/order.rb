require 'pry'

require_relative 'customer.rb'


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

def total
  total = 0.00
  @products.each_value do |value|
    total += value
  end
  total += (total * 0.075) #7.5% tax
  return total.round(2)
end

end

# ID = 123
# EMAIL = "a@a.co"
# ADDRESS = {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# }
# customer = Customer.new(ID, EMAIL, ADDRESS)
#
# products = { "banana" => 1.99, "cracker" => 3.00 }
# myorder = Order.new(1337, products, customer)
#
# binding.pry
