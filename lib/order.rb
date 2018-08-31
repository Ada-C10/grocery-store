require 'csv'
require_relative 'customer'
require 'awesome_print'


class Order
  TAX = 0.075

  attr_reader :id, :customer, :fulfillment_status #readable only
  attr_accessor :products #readable and writable, hash of product name and price

  F_STATUS = [:pending, :paid, :processing, :shipped, :complete] #saved as a constant

  def initialize(id, products_hash, customer, fulfillment_status = :pending) #fulfillment_status has default value if non is provided
    @id = id
    @products = products_hash
    @customer = customer
    @fulfillment_status = fulfillment_status
    raise ArgumentError if not F_STATUS.include?(fulfillment_status) #if fulfillment_status is not include f_status, raise error
  end

  def self.all #returns collection of Order instances, representing all of the Orders in CSV
    orders = []
    CSV.foreach("data/orders.csv") do |row| #load csv, iterate by row
      array = row[1].split(";") #split products which are divided by ; and store it in array
      hash = {} #will store product's name and price
      array.each do |item| #iterate over products
        key,value = item.split(":") #split product's name and price which are separted by : and assign them to key and value
        hash[key] = value.to_f #key's value now = to decimal value (price), product's name and price are in hash
      end
      orders << Order.new(row[0].to_i,hash,Customer.find(row[2].to_i),row[3].to_sym) ##convert order id to integer, use self.find method for customer ID, convert fulfillment_status to symbol
    end
    return orders
  end

  def self.find(id) # returns an instance of Order by order id
    Order.all.find { |order| order.id == id}
  end

  def total #calculates total cost
    prices = @products.values.sum #sums costs stored in value of products hash
    tax = prices * TAX #calculates tax

    final_price = prices + tax #add tax and total cost
    total_price = final_price.round(2) #rounds to 2 decimal places
  end

  def add_product(key, value)
    raise ArgumentError if @products.key?(key) #if product is repeated, = error
    @products[key] = value
  end
end

cust_1 = Customer.new(123, "a@a.co", "123 Main WA 98101") #An instance of Customer, the person who placed this order
