require 'csv'
require_relative 'lib/customer.rb'
require_relative 'lib/order.rb'
require 'awesome_print'

require 'pry'


def main
  customer1 = Customer.new(123, "a@a.co", {street: "123 Main",city: "Seattle",state: "WA",zip: "98101"})
  order1 = Order.new( 1337, { "banana" => 1.99, "cracker" => 3.00 }, customer1, :pending)

  puts customer1
  order1.add_product("salad", 4.25)

  # ap Customer.all[0].id.class
  #
  # ap Customer.find(36)
  # ap Customer.find(4)
  ap Order.all

  def product_hash(order)
      products = order.split(';')
      products_hash = {}
      products.each do |product|
        products_hash[product.split(':')[0]]= product.split(':')[1].to_f
      end
      return products_hash
  end

  puts product_hash("Lobster:17.18;Annatto seed:58.38;Camomile:83.21")
end

main
