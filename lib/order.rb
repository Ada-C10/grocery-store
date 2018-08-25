require 'csv'
require 'pry'

class Order

  TAX = 0.075

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    list_of_statuses = [:pending, :paid, :processing, :shipped, :complete]

    if list_of_statuses.include? fulfillment_status
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "Unknown fulfillment status"
    end

  end

  # returns the total + tax of all the products in an instance of Order
  def total
    subtotal = @products.sum do |key, value|
      value
    end

    total = subtotal + (subtotal * TAX)

    return total.round(2)
  end

  # adds a product to the instance of Order if it does not yet exist
  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError, "Product already exists in the system"
    else
      @products[product_name] = price
    end

  end

  # removes a product from the instance of Order if it does exist
  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError, "Product does not exist in our system"
    end
  end

  # takes a string describing produce and returns a hash with the produce as keys and prices as values
  def self.get_product_list(produce)
    products_list = {}

    produce.split(';').each do |product|
      product_array = product.split(':')
      products_list[product_array[0]] = product_array[1].to_f
    end

    return products_list

  end

  # reads a CSV and returns a list of the data as a list of Orders
  def self.all
    all_orders = CSV.read('data/orders.csv').map do |row|

      id = row[0].to_i
      products_list = get_product_list(row[1])
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym

      self.new(id, products_list, customer, fulfillment_status)

    end

    return all_orders
  end

  # returns instance of Order that matches order id argument
  def self.find(id_number)
    list_of_orders = self.all
    matching_order = list_of_orders.find do |order|
      order.id == id_number
    end

    # returns nil if not found
    return matching_order

  end

  # returns instance of Order that matches customer id argument
  def self.find_by_customer(customer_id)
    list_of_orders = self.all
    matching_order = list_of_orders.find do |order|
      order.customer.id == customer_id
    end

    # binding.pry

    return matching_order

  end

end
