require 'pry'
class Order
  attr_reader :id, :products, :customer, :fulfillment_status
  attr_writer :products, :customer, :fulfillment_status

  @@valid_statuses = %i[pending paid processing shipped complete]

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

    def add_product(product_name, price)
      @products = [:product_name, :price]
    end
end
