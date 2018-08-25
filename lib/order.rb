require 'csv'
require 'ap'
require_relative 'customer'
require 'ap'

class Order

  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  @@orders = []

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_status_list = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError, "Invalid fulfillment status." if !valid_status_list.include? @fulfillment_status
  end

  def total
    total = @products.sum {|k,v| v}
    total *= 1.075
    total.round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError, "Product already in product list." if @products.include? product_name
    @products[product_name] = price
  end

  def remove_product(product_name)
    raise ArgumentError, "Product does not exist." if !@products.include? product_name
    @products.delete(product_name)
  end

  def self.all
    @@orders = []
    CSV.foreach("data/orders.csv") do |order|
      customer_products = order[1].split(";")
      product_hash = {}
      customer_products.each do |item|
        temp = item.split(":")
        product_hash[temp[0]] = temp[1].to_f
      end
      @@orders << Order.new(order[0].to_i, product_hash, Customer.find(order[2].to_i), order[3].to_sym)
    end

    return @@orders
  end

  def self.find(id)
    @@orders = Order.all
    return @@orders.find {|order| order.id == id}
  end

  def self.find_by_customer(customer_id)
    orders = Order.all
    list = orders.find_all {|order| order.customer.id == customer_id}
    return list if !list.empty?
    return nil
  end

end

# orders = Order.all
# puts "#{orders.class}"
# puts "#{orders.length}"
