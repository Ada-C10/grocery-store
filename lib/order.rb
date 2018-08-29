require 'pry'
require_relative 'customer'

class Order
  attr_reader :id, :customer, :products, :fulfillment_status
  # initialize
  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_statuses = %i[pending paid processing shipped complete]

    if valid_statuses.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end
    @id = id
    @customer = customer
    @products = products

  end
  # create a method to calculate the sum after tax
  def total
    sum_before_tax = self.products.values.sum
    sum_after_tax = sum_before_tax * 1.075
    return sum_after_tax.round(2)
  end
  # a method to add product
  def add_product(prd_name, prd_price)
    if @products.keys.include? (prd_name)
      raise ArgumentError,"Product namne exists, try other nanmes"
    else
      @products[prd_name] = prd_price
    end
  end
  # a method to remove product
  def remove_product(prd_name)
    if @products.keys.include? (prd_name)
      @products.delete(prd_name)
    else
      raise ArgumentError,"Product namne does not exist"
    end
  end


  # a method to read  from the csv file and creat the an array for all the orders
  def self.all
    all_orders = []

    CSV.open('data/orders.csv', 'r').map do |line|
      order_info = line.to_a
      order_id = order_info[0].to_i
      fulfillment_status = order_info[-1].to_sym

      customer_id = order_info[-2].to_i
      customer = Customer.find(customer_id)

      prod_info = order_info[1].split(';')
      product_h = {}

      prod_info.each do |prod|
        prod_new = prod.split(':')
        product_h[prod_new.first] = prod_new.last.to_f
      end

      new_order = self.new(order_id, product_h, customer, fulfillment_status)
      all_orders.push(new_order)
    end

    return all_orders
  end
  # find an order with the given order ID
  def self.find(id)
    all_orders = self.all
    order_found = all_orders.select {|order| order.id == id}
    return order_found[0]
  end
  # find a customer based on customer ID
  def self.find_by_customer(customer_id)
    all_orders = self.all   
    order_found = all_orders.select {|order| order.customer.id == customer_id}
    if order_found == []
      return nil
    else
      return order_found
    end
  end
end
