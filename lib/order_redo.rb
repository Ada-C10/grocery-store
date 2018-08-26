require 'pry'
require 'awesome_print'
require_relative '../lib/customer'

# Create a class called `Order`.
class Order

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status


  end

end
address = {
  street: "123 Main",
  city: "Seattle",
  state: "WA",
  zip: "98101"
}

cassy = Customer.new(123, "a@a.co", address)
pending_order = Order.new(123, {}, cassy)
paid_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, cassy, :paid)

binding.pry
