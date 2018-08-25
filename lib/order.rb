require 'pry'
require 'awesome_print'
require 'csv'
require_relative 'customer.rb'

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    if [:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError.new("This is not a valid fulfillment status.")
    end
  end

  # Calculates total cost of all items in products hash, including tax
  def total
    if @products.length == 0
      return 0
    else
      total_cost = @products.values.reduce(:+)
      total_cost *= 1.075
      return total_cost.round(2)
    end
  end

  # Adds product (both key and value) to the products_hash
  def add_product(name, price)
    if @products[name] == nil
      @products[name] = price
    else
      raise ArgumentError.new("This product has already been added.")
    end
  end

  # Removes product (both key and value) from the products_hash
  def remove_product (name)
    if @products[name] == nil
      raise ArgumentError.new("This product cannot be found.")
    else
      @products.delete(name)
    end
  end

  # Helper Method to create the products hash to use as a parameter in Order.all
  # in creating new instances of the Order class from the csv file
  def self.create_product_hash(order)
    products_hash = {}
    a = order[1].split(";")
    i = 0
    while i < a.length
      b = a[i].split(":")
      products_hash[b[0]] = b[1].to_f
      i += 1
    end

    return products_hash
  end

  # Reads CSV and uses the data to create new instances of the Order class
  # Returns an array of all the Order instances
  def self.all
    order_data = []
    order_data = CSV.open('data/orders.csv', 'r').map do |line|
      line
    end

    all_orders = []
    order_data.each do |order|
      products_hash = self.create_product_hash(order)
      all_orders << self.new(order[0].to_i, products_hash, Customer.find(order[2].to_i), order[3].to_sym)
    end

    return all_orders
  end

  # Searches through all Order instances to find a match given the id
  def self.find(id)
    orders = self.all
    orders.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end

  # Searches through all Order instances to find matches given the customer id
  def self.find_by_customer(customer_id)
    customer_list = []
    orders = self.all
    orders.each do |order|
      if order.customer.id == customer_id
        customer_list << order
      end
    end
    if customer_list.length > 0
      return customer_list
    else
      return nil
    end
  end
end
