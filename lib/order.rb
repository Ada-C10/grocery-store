require 'pry'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_FULFILLMENTS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer,  fulfillment_status = :pending)
    # binding.pry
    if  !VALID_FULFILLMENTS.include?(fulfillment_status)
      raise ArgumentError.new("")
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
    sum = sum + sum * (0.075)
    return (sum * 100).round / 100.0
  end

  def add_product(product_name, price)

    if @products.has_key?(product_name)
      raise ArgumentError.new("")

    else
      @products["#{product_name}"] = price
    end
  end

  #
  # self.all
  # end

  # self.find(id)
  # end

  # Order.find_by_customer(customer_id)
  # end
end
