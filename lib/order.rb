require_relative 'customer' #bringing customer.rb file into order.rb
require 'csv' #requiring csv ruby module into order.rb
require 'pry'

class Order
  attr_reader :id, :products
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status= :pending) #should id and ful_st be different?
    @id = id
    @products = products
    @customer = customer#(should this be different?)
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError.new("That is an invalid fulfillment status") unless valid_status.include?(fulfillment_status)
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
      Order.new(row[0].to_i, self.convert_to_hash(row[1]), Customer.find(row[2].to_i), row[3].to_sym) # row[2] issue Expected "25" to be a kind of Customer, not String.
    end
  end

# self.find(id) - returns an instance of Order where
# the value of the id field in the CSV matches the passed parameter
  def self.find(id)
    self.all.find do |order|
      order.id == id
    end
  end

end
