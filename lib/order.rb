require 'pry'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  @@valid_statuses = %i[pending paid processing shipped complete] # array of keys
  @@orders = []
  # example of input: order = Order.new(1337, products, customer)
  # if fulfillment_status was not specified, it should have a pending status
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    check_valid(@fulfillment_status)
  end

  # checks if the fulfillment_status has correct keys
  # return argument error if it has invalid keys
  def check_valid(bogus_status)
    until @@valid_statuses.include?(bogus_status)
      raise ArgumentError, "bogus status!"
    end
  end

  # input = { "banana" => 1.99, "cracker" => 3.00 }
  # returns the sums for all product
  def total
    prices = @products.values
    total = prices.sum
    # add a 7.5% tax to the total and round to 2 decimal points
    total_and_tax = (total * 0.075 + total).round(2)
    # return expected output
    total_cost = total_and_tax == 0.0 ? 0 : total_and_tax
    return total_cost
  end

  # input: order.add_product("salad", 4.25)
  # adds the product to the hash of products
  def add_product(key, value)
    if @products.include?(key) # if it already exists
      raise ArgumentError
    end
    @products[key] = value # add it to the products
  end

  #  input: [["1", #id
  # "Lobster:17.18;Annatto seed:58.38;Camomile:83.21", #products
  # "25", #customer
  # "complete"] # fulfillment_status
  # expects: order = Order.new(1, {}, customer, fulfillment_status)
  # meaning of parameters: id, products, customer, fulfillment_status
  # returns a hash that contains the product as a key and the cost as the value
  def self.products_into_hash(string)
    products_hash = {}
    items = string.split(";")
    items.each do |item|
      key = item.split(":").first
      value = item.split(":").last.to_f
      products_hash[key] = value
    end
    return products_hash
  end

  # returns an array of order instances by taking input from a CSV file
  def self.all
    @@orders = CSV.read('data/orders.csv').map {|line| line}
    @@orders = @@orders.map do |array|
      Order.new(id = array[0].to_i, products = self.products_into_hash(array[1]), customer = Customer.find(array[2].to_i), fulfillment_status = array[3].to_sym)
    end
    return @@orders
  end

  # input: id of order
  # return order instance if it exist, or nil if it doesn't exist
  def self.find(id)
    @@orders = self.all if @@orders.nil? # read orders once 
    order = @@orders.select {|instance| instance.id == id} # returns instance in an array
    return order[0]
  end

end
