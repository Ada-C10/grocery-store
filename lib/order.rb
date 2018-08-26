require 'csv'

require_relative 'customer.rb'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  FULLFILLMENT_STATUS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize (id, products, customer, status = :pending)
    if FULLFILLMENT_STATUS.include?(status) == false
      return raise ArgumentError, 'Not a status'
    end
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = status

  end

  def add_product(item, price)
    if @products.has_key?(item)
      return raise ArgumentError, 'Item already on list'
    else
      new_item = {item => price}
      @products = @products.merge(new_item)
    end
  end

  def total
    total = 0.00
    @products.each_value do |value|
      total += value
    end
    total += (total * 0.075) #7.5% tax
    return total.round(2)
  end

  def self.all
    @orders = []
    CSV.open("./data/orders.csv", "r").each do |row|
      order_id = row[0].to_i

      # go through CSV product list for the current customer, split each for processing into a hash to mee initialization requirement
      order_products = {}
      raw_products = row[1]
      raw_products = raw_products.split(';')
      raw_products.each do |raw_product|
        raw_product = raw_product.split(':')
        product = { raw_product[0] =>
          raw_product[1].to_f }
          order_products = order_products.merge(product)
        end

        customer_id = row[2].to_i
        customer = Customer.find(customer_id)
        order_status = row[3].to_s
        final_status = ""
        FULLFILLMENT_STATUS.each do |status|
          if order_status.to_sym == status
            final_status = status
          end
        end
        order = Order.new(order_id, order_products, customer, final_status)
        @orders << order
      end
      return @orders
    end

    def self.find(id)
      @orders = Order.all
      @orders.each do |order|
        if order.id == id
          return order
        end
      end
      return nil
    end
  end
