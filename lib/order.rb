require 'csv'
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    status = [:pending, :paid, :processing, :shipped, :complete]
    if status.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "Not a valid status"
    end
    @id = id
    @products = products
    @customer = customer
  end

  def total
    total = @products.sum {|product,price| price}
    total *= 1.075
    total = total.round(2)
    return total
  end

  def add_product(product, price)
    if @products.keys.include?(product)
      raise ArgumentError, "That product already exists"
    else
      @products[product] = price
    end
  end

  def self.product_hash
    order_array = []
    product_hash = {}

    Order.all.each do |line|
      order_array = line[1].split(";")
    end

    order_array.each do |order|
      split = order.split(":")
      product_hash[split[0]] = split[1].to_f
    end
    return product_hash
  end

  def self.all
    order_array = []
    product_hash = {}

    CSV.open("data/orders.csv", 'r').map do |line|

      order_array = line[1].split(";")

      order_array.each do |order|
        split = order.split(":")
        product_hash[split[0]] = split[1].to_f
      end
    end
    return Order.new(line[0].to_i, product_hash, line[2].to_i, line[3])
  end

  # def self.find(id)
  #
  # end
end
