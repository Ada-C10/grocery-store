require 'pry'
require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  #initialize class variable orders
  @@orders = []

  VALID_FULFILLMENTS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer,  fulfillment_status = :pending)

    if !VALID_FULFILLMENTS.include?(fulfillment_status)

      raise ArgumentError.new("Not a valid status")
    end

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

  end

  def total
    sum = @products.reduce(0) do |total,(item, cost)|
      total + cost
    end

    return ((sum + sum * 0.075) * 100).round / 100.0
  end

  def add_product(product_name, price)

    if @products.has_key?(product_name)
      raise ArgumentError.new("")

    else
      @products["#{product_name}"] = price
    end
  end

  def self.all

    @@orders = CSV.open('data/orders.csv', "r+").map do |order|
      order
    end

    # Adzuki Beans:3.1; ....
    #split customer[1] into each product => price
    #pass in split product hashes, etc to instantiate
    @@orders = @@orders.map do |order|

      products = order[1].split(";")
      split_products_hash = {}

      products.each do |product|

        split_product = product.split(":")

        split_products_hash[split_product[0]] = split_product[1].to_f

      end

      Order.new(order[0].to_i, split_products_hash, Customer.find(order[-2].to_i), order[-1].to_sym)
    end

    return @@orders
  end

  #populates orders class variable with cvs data by calling self.all method 
  @@orders = self.all

  # self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter

  def self.find
  end



  # order array
  # id = 1
  # products = {
  #   "Lobster" => 17.18,
  #   "Annatto seed" => 58.38,
  #   "Camomile" => 83.21
  # }
  # customer_id = 25
  # fulfillment_status = :complete

  # Order.find_by_customer(customer_id)
  # customer = Customer.all
  # end
end
