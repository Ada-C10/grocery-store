# Create a class called Order. Each new Order should include the following attributes:
#
# ID, a number (read-only)
# A collection of products and their cost. This data will be given as a hash that looks like this:
# { "banana" => 1.99, "cracker" => 3.00 }
# Zero products is permitted (an empty hash)
# You can assume that there is only one of each product
# An instance of Customer, the person who placed this order
# A fulfillment_status, a symbol, one of :pending, :paid, :processing, :shipped, or :complete
# If no fulfillment_status is provided, it will default to :pending
# If a status is given that is not one of the above, an ArgumentError should be raised
#

require_relative 'customer.rb'
require 'money'

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
  # add product name and cost to a hash, "name" as key, cost as value
  def add_product(name, cost)
    @products.each do |key, value|
      if key == name
        raise ArgumentError
      end
    end
    @products[name] = [cost]
  end
    # A total method which will calculate the total cost of the order by:
    # Summing up the products
    # Adding a 7.5% tax
    # Rounding the result to two decimal places
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
  end
