require_relative 'customer'
require 'csv'
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

  def self.all
    orders = CSV.read('data/orders.csv').map do |order|
      order
    end

    all_orders = orders.map do |order|
      @id = order[0].to_i
      @products = {}
        items_split = order[1].split(';')
        product_and_prices_split = items_split.map do |item|
          item.split(':')
        end
        product_and_prices_split.each do |product|
          @products[product[0]]= product[1].to_f
        end
      @customer = Customer.find(order[2].to_i)
      @fulfillment_status = order[3].to_sym
      Order.new(@id, @products, @customer, @fulfillment_status)
    end

    return all_orders
  end

  def self.find(id)
  end




end

# address = {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# }
# customer = Customer.new(123, "a@a.co", address)
# products = { "banana" => 1.99, "cracker" => 3.00 }
# order = Order.new(1337, products, customer)
puts Order.all
