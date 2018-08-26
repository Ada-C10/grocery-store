
require 'csv'
require_relative 'customer'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status
  attr_writer :products, :customer, :fulfillment_status

  @@valid_statuses = %i[pending paid processing shipped complete]
  @@orders = []

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid(fulfillment_status)
  end

  def valid(fulfillment_status)
    unless @@valid_statuses.include?(fulfillment_status)
      raise ArgumentError
    end
  end

  def total
    tax = products.values.sum * 0.075
    total = tax + products.values.sum
    total = total.round(2)
  end

  def add_product(product_name,price)
    if @products.include?(product_name)
      raise ArgumentError
    else
      @products.store(product_name,price)
    end
  end

  def self.all
    @@orders = []
     CSV.foreach("data/orders.csv") do |line|
      product_hash = {}
      line[1].split(";").each do |item|
        split = item.split(":")
        product_hash[split[0]] = split[1].to_f
      end
      @@orders << self.new(line[0].to_i, product_hash, Customer.find(line[2].to_i), line[3].to_sym)
    end
    return @@orders
  end

  def self.find(id)
    self.all
    return @@orders.find {|order| order.id == id}
  end

end
