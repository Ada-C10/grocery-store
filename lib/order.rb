require 'csv'
require_relative 'Customer'

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_statuses = %i[pending paid processing shipped complete]
    @id = id
    @products = products
    @customer = customer
    raise ArgumentError unless valid_statuses.include?(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end

  def total
    subtotal = @products.values.sum
    total = 1.075 * subtotal
    return total.round(2)
  end

  def add_product(product_name, cost)
    raise ArgumentError if @products.keys.include?(product_name)
    @products[product_name] = cost
  end

  def remove_product(product_name)
    raise ArgumentError unless @products.keys.include?(product_name)
    @products.delete(product_name)
  end

  def self.all
    all_orders = CSV.read("../data/orders.csv").map do |order_info|
      id = order_info[0].to_i
      products = {}
      product_with_price = order_info[1]

      product_with_price.split(';').each do |product|
        name_and_price = product.split(":")
        products[name_and_price[0]] = name_and_price[1].to_f
      end

      customer = Customer.find(order_info[2].to_i)
      fulfillment_status = order_info[3].to_sym

      Order.new(id, products, customer, fulfillment_status)
    end
    return all_orders
  end

  def self.find(order_id)
    all_orders = self.all
    found_order = all_orders.find { |order| order.id == order_id }
    return found_order
  end

  def self.find_by_customer(customer_id)
    raise ArgumentError if Customer.find(customer_id) == nil
    all_orders = self.all
    all_orders.find_all do |order|
      order.customer.id == customer_id
    end
  end
end
