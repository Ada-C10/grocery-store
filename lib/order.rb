require_relative 'customer'
require 'csv'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  # @@all_orders = []

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    validate_fulfillment_status
    # @@all_orders << self
  end


  def validate_fulfillment_status
    fulfillment_status_options = [:pending, :paid, :processing, :shipped, :complete]
    if fulfillment_status_options.include?(fulfillment_status) == false
      raise ArgumentError.new("Fulfillment status must be :pending, :paid, :processing, :shipped, or :complete")
    end
  end


  def total
    total_cost = 0

    @products.each do |product, cost|
      total_cost += cost
    end

    total = total_cost + (total_cost * 0.075)
    return total.round(2)
  end


  def add_product(product_name, price)
    check_product_duplicates(product_name)
    @products[product_name] = price
  end


  def check_product_duplicates(product_name)
    @products.each do
      if @products.key?(product_name)
        raise ArgumentError.new("A product with that name already exists.")
      end
    end
  end

  # def self.all
  #   return @@all_orders
  # end



  def self.transform_csv
    all_orders = []
    CSV.open("data/orders.csv", "r").each do |array|
      order = []
      id = array.slice(0)
      products = array.slice(1..(array.length - 3))
      customer = array.slice (-2)
      fulfillment_status = array.slice(-1)
      order << id
      order << products
      order << customer
      order << fulfillment_status
      all_orders << order
    end
    return all_orders
  end
end
