require_relative 'customer'
require 'csv'
require 'pry'
require 'awesome_print'


class Order
  attr_reader :id, :products, :customer, :fulfillment_status
  FULLFILLMENT_STATUS = [:pending, :paid, :processing, :shipped, :complete]
  
  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    until FULLFILLMENT_STATUS.include?(@fulfillment_status)
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
    orders = Order.all

    existing_order = orders.detect do |order|
      order.id == id
    end

    return existing_order
  end

  def remove_product(product_name)

    not_a_product = @products.keys.none? do |name|
      name == product_name
    end

    if not_a_product
      raise ArgumentError, "Product not in the list"
    end

    @products.delete_if do |name, price|
      name == product_name
    end
  end

  def self.find_by_customer(customer_id)
    orders = Order.all
    list = ""

    matching_orders = orders.select do |order|
      order.customer.id == customer_id
    end

    matching_orders.each_with_index do |order_instance, i|
      each_instance = "\n#{i + 1}. #{order_instance}"
      list << each_instance
    end

    return list
  end
end
