require 'pry'
require 'awesome_print'

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

  def total
    if @products.length == 0
      return 0
    else
      total_cost = @products.values.reduce(:+)
      total_cost *= 1.075
      return total_cost.round(2)
    end
  end

  def add_product(name, price)
    if @products[name] == nil
      @products[name] = price
    else
      raise ArgumentError.new("This product has already been added.")
    end
  end

  def remove_product (name)
    if @products[name] == nil
      raise ArgumentError.new("This product cannot be found.")
    else
      @products.delete(name)
    end
  end
end
