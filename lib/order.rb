require 'pry'
require 'awesome_print'
require_relative '../lib/customer'

class Order
  # Setting attributes to be read-only
  attr_reader :id, :products, :customer, :fulfillment_status

  # Initializing with fultillment_status defaulting to :pending
  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id
    @products = products
    @customer = customer
    # Setting fulfilmment options
    fulfillment_options = [:pending, :paid, :processing, :shipped, :complete]
    # Checking if fulfillment_option is valid
    if fulfillment_options.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "Please enter a valid fulfillment status"
    end
  end

  # Calculating total from products
  def total
    # RETURN 0 IF products is empty
    if products.length == 0
      return 0
    else
      # SUMMING products
      sum = products.values.reduce(:+)
      # CALCULATING tax
      tax = sum * 0.075
      # RETURNING total
      return (sum + tax).round(2)
    end
  end

  def add_product(product_name, price)
    # ADDING data to hash
    # IF already in hash, RAISE ArgumentError
    if @products.include?(product_name)
      raise ArgumentError, 'Product has already been added'
    else
      @products[product_name] = price
    end
  end

  # RETURNS a collection of Order instances,
  # representing all of the Orders described in the CSV file
  def self.all
   # OPENING orders.csv
    data = CSV.open("data/orders.csv", headers: true).map do |item|
      # CREATING a new order instance for each item
      # id - Set to be an integer value
      id = item["id"].to_i

      # customer - instance of customer
      customer = Customer.find(item["customer"].to_i)

      # status - fulfillment status as symbol
      status = item["status"].to_sym

      # Creating empty hash to hold product key/value pairs
      product_hash = {}
      # SPLITTING products into pairs by ;
      item["products"].split(";").map do |pair|
        # SPLITTING each product key/value pair by :
        item = pair.split(":")
        # ADDING item to product_hash
        product_hash[item[0]] = item[1].to_f
      end
      # SETTING old products value to new product hash
      products = product_hash
      # CREATING instance of Order
      Order.new(id, products, customer, status)
    end
  end

  # self.find(id) - RETURNS an instance of Order where values
    # in id field in the CSV match the passed parameter
  def self.find(id)
    # RETURNS order if id is found
    return self.all.find { |order| order.id == id }
  end
end
