require_relative 'customer'
require 'csv'

class Order

  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    validate_fulfillment_status
  end


  def validate_fulfillment_status
    fulfillment_status_options = [:pending, :paid, :processing, :shipped, :complete]
    if fulfillment_status_options.include?(fulfillment_status) == false
      raise ArgumentError.new("Fulfillment status must be :pending, :paid, :processing, :shipped, or :complete")
    end
  end


  def total
    total_cost = 0

    @products.each do |product, cost|
      total_cost += cost
    end

    total = total_cost + (total_cost * 0.075)
    return total.round(2)
  end


  def add_product(product_name, price)
    check_product_duplicates(product_name)
    @products[product_name] = price
  end


  def check_product_duplicates(product_name)
    @products.each do
      if @products.key?(product_name)
        raise ArgumentError.new("A product with that name already exists.")
      end
    end
  end


  # def self.all
  #   all_orders = []
  #   CSV.open("data/orders.csv", "r").each do |array|
  #     order = []
  #
  #     id = array.slice(0)
  #     products = array.slice(1..(array.length - 3))
  #     customer = array.slice (-2)
  #     fulfillment_status = array.slice(-1)
  #
  #     products_new = products[0].split(';')
  #
  #     products_hash = {}
  #     products_new.each do |product|
  #       product2 = product.split(':')
  #       products_hash[product2[0]] = product2[1]
  #     end
  #
  #     new_order = Order.new(id, products_hash, customer, fulfillment_status.to_sym)
  #     all_orders << new_order
  #
  #   end
  #   return all_orders
  # end


  def self.create_product_hash(products)
    products.each do |product|
      products_new = product.split(';')
      @products_hash = {}
      products_new.each do |product|
        product2 = product.split(':')
        @products_hash[product2[0]] = product2[1].to_f
      end
      return @products_hash
    end
  end


  def self.transform_data
    all_data = []
    CSV.open("data/orders.csv", "r").each do |array|
      order = {}

      products = create_product_hash(array.slice(1..(array.length - 3)))

      order[:id] = array.slice(0).to_i
      order[:products] = products
      order[:customer] = array.slice(-2)
      order[:fulfillment_status] = array.slice(-1).to_sym

      all_data << order
    end
    return all_data
  end


  def self.all
    @all_orders = []

    transform_data.each do |order_data|

      new_order = Order.new(order_data[:id], order_data[:products], order_data[:customer], order_data[:fulfillment_status])

      @all_orders << new_order
    end
    return @all_orders

  end

  def self.find(id)
    Order.all.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end
  


  def self.new_customer_instance
    @new_customers = []
    self.all.each do |order|
      if Customer.find(order.customer)
        new_customer = Customer.new(customer.id, customer.email, customer.address)

        @new_customers << new_customer
      end
    end
    return @new_customers
  end

end






#
# def self.all
#   all_orders = []
#   CSV.open("data/orders.csv", "r").each do |array|
#     order = []
#
#     id = array.slice(0)
#     products = array.slice(1..(array.length - 3))
#     customer = array.slice (-2)
#     fulfillment_status = array.slice(-1)
#
#     products_new = products[0].split(';')
#
#     products_hash = {}
#     products_new.each do |product|
#       product2 = product.split(':')
#       products_hash[product2[0]] = product2[1]
#     end
#
#     new_order = Order.new(id, products_hash, customer, fulfillment_status.to_sym)
#     all_orders << new_order
#
#   end
#   return all_orders
# end
#










#
# end
