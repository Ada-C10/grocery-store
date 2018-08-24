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

  def get_product_list(produce_list)
    binding.pry
    products_list = produce_list.map do |product|
      product_array = product.split(':')
      products_list[product_array[0]] = product_array[1]
    end


    return products_list

  end


  def self.all
    list_of_orders =[]
    CSV.read('data/orders.csv').each do |row|
      products_list = {}
      row[1].split(';').each do |product|
        product_array = product.split(':')
        products_list[product_array[0]] = product_array[1]
      end

      list_of_orders << {
        :id => row[0],
        :products => products_list,
        :customer => row[2],
        :fulfillment_status => row[3].to_sym
      }

    end

    all_orders = list_of_orders.map do |order_info|
      self.new(order_info[:id], order_info[:products], order_info[:customer], order_info[:fulfillment_status])

    end

    return all_orders
  end

end


# An add_product method which will take in two parameters, product name and price, and add the data to the product collection
# If a product with the same name has already been added to the order, an ArgumentError should be raised
