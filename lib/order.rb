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
    if !list_of_statuses.include? fulfillment_status
      raise ArgumentError, "Unknown fulfillment status"
    else
      @fulfillment_status = fulfillment_status
    end
  end

  def total
    subtotal = @products.sum do |key, value|
      value
    end

    total = subtotal + (subtotal * TAX)

    return total.round(2)
  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError, "Product already exists in the system"
    else
      @products[product_name] = price
    end

  end

  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError, "Product does not exist in our system"
    end
  end

  def self.get_product_list(produce_list)

    products_list = {}
    produce_list.split(';').each do |product|
      product_array = product.split(':')
      products_list[product_array[0]] = product_array[1].to_f
    end

    return products_list

  end


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

end


# An add_product method which will take in two parameters, product name and price, and add the data to the product collection
# If a product with the same name has already been added to the order, an ArgumentError should be raised
