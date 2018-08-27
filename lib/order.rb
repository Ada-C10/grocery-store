require_relative 'customer' #brining customer.rb file into order.rb
require 'csv' #requiring csv ruby module into order.rb

class Order
  attr_reader :id, :products
  attr_accessor :products, :customer, :fulfillment_status

#fulfillment_status is set to :pending as a default
#id , products customer , fulfilment status, should be symbols?
# order = Order.new(id, {}, customer, fulfillment_status)

  def initialize(id, products, customer, fulfillment_status= :pending) #should id and ful_st be different?
    @id = id
    @products = products
    @customer = customer#(should this be different?)
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

  # Lobster:17.18;Annatto seed:58.38;Camomile:83.21
  #.split
  def self.convert_to_hash(products_string)
    array = products_string.split(";")
    array2 = []
    array.each do |s|
      array2 << s.split(":")
    end
    return products_hash = Hash[array2.map {|k,v| [k,v.to_f]}]
  end

#   self.all - returns a collection of Order instances,
#   representing all of the Orders described in the CSV file
  def self.all
    CSV.open('data/orders.csv', 'r').map do |row|
      Order.new(row[0].to_i, self.convert_to_hash(row[1]), row[2].to_i, row[3].to_sym)
    end
  end


# self.find(id) - returns an instance of Order where
# the value of the id field in the CSV matches the passed parameter


end

# id = 1337
# fulfillment_status = :shipped
# order = Order.new(id, {}, customer, fulfillment_status)
#
# p kay = Customer.new(2822, "kay@mail.com", :street => "2920", :city =>"seattle", :state =>"wa", :zip =>98192)
#
# p new_order = Order.new(111, {"tea" => 5.5, "coffee" => 9}, kay, fulfillment_status: :shipped)
# p new_order.total
# p new_order.add_product("water", 100)
# p new_order.products
# p new_order.add_product("water", 100)
