require_relative '../lib/customer'
require 'pry'
require 'csv'

# Method to take the string of the orders and transform them into a hash

def product_string_to_hash(product_str)
  to_arr = product_str.split(";")
  new_arry = to_arr.map do |s|
    s.split(":")
  end
  prod_hash = {}
  new_arry.each do |prod_price|
    prod_hash[prod_price.first] = prod_price[1].to_f
  end
  return prod_hash
end



class Order

  attr_reader :id, :products, :customer, :fulfillment_status
  # set status to :pending if nothing is passed in

  def initialize(id, products, customer, fulfillment_status = :pending)
    # raise an argument error if bogus status is passed
    if
      (fulfillment_status != :pending && fulfillment_status != :paid && fulfillment_status != :processing && fulfillment_status != :shipped && fulfillment_status != :complete)
      begin
        raise ArgumentError.new("That's bogus!")

      end
    end

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status


  end

  # total method to sum products
  # add 7.5% tax
  # # round 2 decimal places


    def total
      price_array = @products.map do |item, price|
        price
      end
      pre_total = price_array.reduce(0, :+)
      tax_total = (pre_total * 0.075) + pre_total
      return tax_total.round(2)
    end

  # add data to product collection[]
    def add_product(product, price)
      if @products.has_key?(product)
        begin
          raise ArgumentError.new("Item is already inluded!")
        end
      elsif
        @products[product] = price
      end
    end

    def self.all
      # inport csv file, into all_orders. map over that array to create a new array of Orders. Calls the product_string_to_hash to turn the string of oder info into a hash. Set the id to an integer. Return the instances of all Orders . Set the fullfillment_status to symbol

      all_orders = CSV.read("data/orders.csv")
        orders_array = all_orders.map do |data|

          products_hash = product_string_to_hash(data[1])
          cust = Customer.find(data[2].to_i)

        Order.new(data[0].to_i, products_hash, cust, data[3].to_sym)
        end
        return orders_array
    end

    def self.find(id)
      orders = Order.all
      find_order = orders.select do |order|
        order.id == id
      end
      return find_order.first
    end
end
