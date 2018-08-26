require 'pry'
require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

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
      raise ArgumentError.new("Adding product that already exists")

    else
      @products["#{product_name}"] = price
    end
  end

  #OPTIONAL WAVE 1
  def remove_product(product_name)

    if !(@products.has_key?(product_name))
      raise ArgumentError.new("Can't remove product that does not exist.")
    end

    @products.delete(product_name)

  end

  def self.all

    orders = CSV.open('data/orders.csv', "r+").map do |order|
      # order

      # Adzuki Beans:3.1; ....
      #split customer[1] into each then loop through to create product hash: product => price
      products = order[1].split(";")
      split_products_hash = {}

      products.each do |product|

        split_product = product.split(":")
        split_products_hash[split_product[0]] = split_product[1].to_f

      end

      #pass in split product hashes, etc to instantiate
      Order.new(order[0].to_i, split_products_hash, Customer.find(order[-2].to_i), order[-1].to_sym)
    end

    return orders
  end

  def self.find(id)

    @@orders ||= Order.all

    found_order = @@orders.find do |order|

      order.id == id

    end

    return found_order
  end
end


# OPTIONAL WAVE 2
# Order.find_by_customer(customer_id) - returns a list of Order instances where the value of the customer's ID matches the passed parameter.
