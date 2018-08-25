require_relative 'customer'
require 'pry'

class Order
  FULLFILLMENT_STATUS = %w(:pending :paid :processing :shipped :complete)
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    until @fulfillment_status == :pending ||
      @fulfillment_status == :paid ||
      @fulfillment_status == :processing ||
      @fulfillment_status == :shipped ||
      @fulfillment_status == :complete
      raise ArgumentError, "Unknown status - status is not in the provided list"
    end
  end

  def total
    product_prices = @products.map do |product|
      product[1]
    end

    products_sum = product_prices.sum
    products_taxed = products_sum + (products_sum * 0.075)
    products_total = products_taxed.round(2)

    return products_total
  end

  def add_product(product_name, price)

    if @products.keys.include?(product_name)
      raise ArgumentError, "Product is already in the order"
    else
      @products["#{product_name}"] = price.to_f.round(2)
    end
    
  end

end

address = {
  street: "123 Main",
  city: "Seattle",
  state: "WA",
  zip: "98101"
}
customer = Customer.new(123, "a@a.co", address)
products = { "banana" => 1.99, "cracker" => 3.00 }
order = Order.new(1337, products, customer)
puts order.total
