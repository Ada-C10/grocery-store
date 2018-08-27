require 'csv'
require 'awesome_print'
require 'pry'
require_relative 'customer'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@orders = []

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid_statuses = %i[pending paid processing shipped complete]

    unless valid_statuses.include?(fulfillment_status) then
      raise ArgumentError, "wrong status entered"
    end
    order_push
  end


  def total
    total_without_tax = 0
    total_with_tax = 0
    @products.each do |product, price|
      total_without_tax = total_without_tax + price
      total_with_tax = (total_without_tax * 0.075) + total_without_tax
    end
    return total_with_tax.round(2)
  end

  def add_product(product, price)
    if @products[product]
      raise ArgumentError, "product already entered"
    else
      @products[product] = price
    end
  end


  def self.all
    return @@orders
  end

def order_push
    @@orders.push(self)
  end

  def self.find(id)
    @@orders.each do |order|
      if order.id == id
        return order
      end
    end
  end
end

# 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete


CSV.read('../data/orders.csv').each do |cust_row|
product_hash = {}
 puts a = cust_row[1].split(';')
   a.each do |product|
     b = product.split(':')
     # puts b
     product_hash[b[0]] = b[1]
   end

customer = Customer.find(cust_row[2].to_i)
 Order.new(cust_row[0], product_hash, customer, cust_row[3])
end
