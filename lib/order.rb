require 'csv'
require_relative 'customer'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, product_hash, customer, fulfillment_status = :pending)
    @id = id
    @products = product_hash
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid_statuses = %i[pending paid processing shipped complete]

    unless valid_statuses.include?(@fulfillment_status)
      raise ArgumentError, 'Not a valid order'
    end
  end

  def total
    sum = @products.values.sum
    return (sum*1.075).round(2)
  end

  def add_product(name, price)
    if @products.has_key?(name)
      raise ArgumentError, 'This product already exists in order!'
    end
    return @products.merge!(name => price)
  end

  def remove_product(name, price)
    unless @products.has_key?(name)
      raise ArgumentError, 'This product does not exist in order!'
    end
    return @products.delete(name)
  end

  def self.all
    all_orders = CSV.open("data/orders.csv", "r").map do |line|
      Order.new(line[0].to_i, self.make_hash(line[1]), Customer.find(line[2].to_i), line[3].to_sym)
    end
    return all_orders
  end

  def self.make_hash(string)
    array = string.split(';')
    hash = {}
    array.each do |e|
      key_value = e.split(':')
      hash[key_value[0]] = key_value[1].to_f
    end
    return hash
  end

  def self.find(id)
    all_orders = self.all
    all_orders.length.times do |i|
      if all_orders[i].id == id
        return all_orders[i]
      end
    end
    return nil
  end
  
end
