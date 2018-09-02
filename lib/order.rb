require_relative 'customer'
require 'csv'
require 'pry'

def products_costs_hash(string)
  remove_semi_colon = string.split(";")
  remove_colon = remove_semi_colon.map do |i|
    i.split(":")
  end
  products_costs = Hash[*remove_colon.flatten]
  products_costs.each do |key, value|
    products_costs[key] = value.to_f
  end

  return products_costs
end

class Order
  @@order = []

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    fulfillment_status_options = [:pending, :paid, :processing, :shipped, :complete]
    if fulfillment_status_options.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
      @fulfillment_status ||= :pending
    else
      raise ArgumentError, 'Status must be: :pending, :paid, :processing, :shipped, :complete'
    end
  end

  attr_reader(:id, :products,:customer, :fulfillment_status)

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

  def self.all
    @@order = CSV.open('data/orders.csv', 'r').map do |line|
      customers = Customer.all
      products_costs = products_costs_hash(line[1])
      customers.each { |customer| @customer = customer if customer.id == line[2].to_i }
      self.new(line[0].to_i, products_costs, @customer, line[3].to_sym)
    end
    return @@order
  end

  def self.find(id)
    orders = Order.all
    @found = nil
    orders.each { |item| @found = item if item.id.to_i == id }
    return @found
  end

  def self.find_by_customer(customer_id)
    order_list = Order.all
    orders = []
    order_list.each { |purchase| orders << purchase if customer_id == purchase.customer.id.to_i }
    return orders
  end

end
