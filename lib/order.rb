require 'csv'
require 'pry'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses = %i[pending paid processing shipped complete]
    raise ArgumentError, "Invalid fulfillment_status" unless valid_statuses.include?(@fulfillment_status)
  end

  def total
    product_sum = @products.values.sum
    sum_plus_tax = product_sum * 1.075
    return sum_plus_tax.round(2)
  end

  def add_product(name, price)
    if @products.keys.include?(name)
      raise ArgumentError, "Duplicate product"
    else
      @products[name] = price
    end
  end

  def self.product_parse(products)
    product_hash = {}
    products_split = products.split(';')
    products_split.each do |product|
      product_array = product.split(":")
      product_hash[product_array[0]] = product_array[1].to_f
    end
    # binding.pry
    return product_hash
  end

  def self.all
    order_list = []
    CSV.read('data/orders.csv').each do |line|
      product = Order.product_parse(line[1])
      order_list << Order.new(line[0].to_i, product, Customer.find(line[2].to_i), line[3].to_sym)
    end
    return order_list
  end

  def self.find(id)
    return self.all[id - 1]
  end

  def self.find_by_customer(customer_id)
    all_orders = self.all
    matching_orders = []
    all_orders.each do |order|
      matching_orders << order unless order.customer.id != customer_id
      # binding.pry
    end
    return matching_orders
  end
end
