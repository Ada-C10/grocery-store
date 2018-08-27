require_relative "customer.rb"
require "csv"

class Order

  attr_reader :id
  attr_accessor :customer, :products, :fulfillment_status

  @@orders = []
  @@found_order = nil

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError if ![:pending, :paid, :processing, :shipped, :complete].include? (fulfillment_status)

    @id = id
    @products = products #give as a hash with name of item and price ("banana" => 1.99)
    @customer = customer # person who placed the order.  An instance of customer class
    @fulfillment_status = fulfillment_status

  end

  def total
    if @products == {}
      return 0
    else
      total = 0
      @products.each do |name, price|
        total = price + total
      end
      return (total + (total * 0.075)).round(2)
    end
  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError
    else
      return @products[product_name] = price
    end
  end

#Order comes in from CSV file as:
  # 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete

  def self.all
    @@orders = CSV.open("data/orders.csv", "r").map do |line|
      id = line[0].to_i

      products = Hash[*line[1].split(/:|;/)]
      products.each do |name, price|
        products[name] = price.to_f
      end

      customer = Customer.find(line[2].to_i)

      fulfillment_status = line[3].to_sym

      Order.new(id, products, customer, fulfillment_status)
    end
    return @@orders
  end


  # def self.find(id)
  #   Order.all.each do |order|
  #     if order.id == id
  #       return order
  #     else
  #       return nil
  #     end
  #   end
  # end

end
