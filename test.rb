require 'csv'
require_relative 'lib/customer.rb'
require_relative 'lib/order.rb'
require 'awesome_print'

require 'pry'


def main
  customer1 = Customer.new(123, "a@a.co", {street: "123 Main",city: "Seattle",state: "WA",zip: "98101"})
  order1 = Order.new( 1337, { "banana" => 1.99, "cracker" => 3.00 }, customer1, :pending)


  #puts customer1
  order1.add_product("salad", 4.25)


  order1 = order1.remove_product("banana")
  ap order1
  # ap Customer.all[0].id.class
  #
  # ap Customer.find(36)
  # ap Customer.find(4)
  #ap Order.all

  #ap Order.all.first
  ap Order.find_by_customer(4)
  ap Order.find_by_customer(500)
end

main
