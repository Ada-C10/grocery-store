require_relative 'customer'
require 'pry'

class Order

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    if fulfillment_status != :pending && fulfillment_status != :paid && fulfillment_status != :processing  && fulfillment_status != :shipped && fulfillment_status != :complete
      raise ArgumentError, 'Status must be: :pending, :paid, :processing, :shipped, :complete'
    else
      @fulfillment_status = fulfillment_status
      @fulfillment_status ||= :pending
    end

  end

  attr_reader(:id, :products, :fulfillment_status, :customer, :total)

  def total
    sum = products.values.sum
    percent = sum * 0.075
    return @total = ("%.2f" % (sum + percent)).to_f
  end

  def add_product(name, price)
    if @products.keys.include?(name)
      raise ArgumentError, 'A product with the same name has already been added to the order'
    else
      return products[name] =  price
    end
  end

  def remove_product(product_name)
    if @products.keys.include?(product_name)
      @products.delete_if {| name, price | name.include?(product_name) }
    else
      raise ArgumentError, 'This product has not been found'
    end

  end
end
