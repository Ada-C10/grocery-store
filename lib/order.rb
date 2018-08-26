
require_relative 'customer.rb'
require 'csv'

class Order
  attr_reader :id
  attr_accessor :customer, :products, :fulfillment_status

  def initialize (id, product, customer, fulfillment_status = :pending)

    @id = id
    @products = product
    @customer = customer
    @fulfillment_status = fulfillment_status
    good_status = [:pending, :paid, :processing, :shipped, :complete]
    if good_status.include?(@fulfillment_status) == false
      raise ArgumentError
    end
  end

  def add_product(name, cost)
    @products.each do |key, value|
      if key == name
        raise ArgumentError
      end
    end
    @products[name] = [cost]
  end

  def total
    product_sum = 0
    product_prices = []
    @products.each do |key, value|
      product_prices << value
    end
    product_prices.each do |value|
      product_sum = product_sum + value
    end
    total = (product_sum * 0.075) + product_sum
    total_money = (total * 100).round / 100.0
    return total_money
  end

  def self.all
    orders = []
    CSV.read('data/orders.csv').each do |order_array|
      id = order_array[0].to_i
      product_hash = {}
      @item_price = order_array[1].split(";")
      @item_price.each do |line|
        split_item = line.split(":")
        item = split_item[0]
        price = split_item[1].to_f
        product = {item => price}
        product_hash.merge!(product)
      end
      customer = Customer.find(order_array[2].to_i)
      status = order_array[3].to_sym
      orders << Order.new(id, product_hash, customer, status)
    end
    return orders
  end

  def self.find(order_id)
    self.all.select do |orders_array|
      orders_array.each do |item|
      return orders_array if orders_array[0] == order_id
    end
    return nil
  end
end
