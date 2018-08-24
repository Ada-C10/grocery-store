require_relative 'customer.rb'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError unless valid_statuses.include? fulfillment_status
    @fulfillment_status = fulfillment_status
  end

  def self.extract_products(products)
    product_hash = {}
    individual_product_prices = products.split(';')
    individual_product_prices.each do |product_price|
      product_price_array = product_price.split(':')
      product_hash[product_price_array[0]] = product_price_array[1].to_f
    end

    return product_hash
  end

  def self.all
    order_list = CSV.open("data/orders.csv", "r").map do |line|
      self.new(line[0].to_i, self.extract_products(line[1]), Customer.find(line[2].to_i), line[3].to_sym)
    end
    return order_list
  end

  def self.find(id)
    self.all.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end

  def self.find_by_customer(customer_id)
    customer_orders = []
    self.all.each do |order|
      if order.customer.id == customer_id
        customer_orders << order
      end
    end
    (customer_orders.length > 0) ? (return customer_orders) : (return nil)
  end

  def total
    total = 0.00
    @products.each do |item, cost|
      total += cost
    end

    total *= 1.075
    return total.round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError if @products.keys.include? product_name
    @products[product_name] = price
  end

  def remove_product(product_name)
    @products.delete(product_name) { raise ArgumentError }
  end

end
