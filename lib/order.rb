require_relative 'customer'
require 'csv'
require 'pry'

# Wave 1 order class creations

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  @@orders = []

  def initialize(id, products, customer, fulfillment_status = :pending)

    @id = id
    @products = products
    @customer = customer
    if [:pending, :paid, :processing, :shipped, :complete].include?fulfillment_status
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end
  end

  # add new product, raise an argument error if the product already exists
  def add_product(product, price)
    # check if the product exists
    @products.each do |item, price|
      if item == product
        raise ArgumentError
        # Adds the data to the product collection
      end
    end
    @products[product] = price

    return @products
  end

  # Tally the total prices and return total cost with tax calculated
  def total
    total = 0.00
    if @products != nil
      @products.each do |product, price|
        # sums products
        total += price
      end
      # Adds a 7.5% tax
      total += (total * 0.075)
    end
    # total amount rounded to two decimal points
    return total.round(2)
  end

  # optional method - removal of products

  def remove_product(product)
    if @products == {}
      raise ArgumentError
    elsif @products.include?(product) == false
      raise ArgumentError
    else
      return @products.delete_if{|item| item == product}
    end
  end

  # Wave 2
  # Creating a global varaible outside the class to be called in in the class above to load the data ones

  def self.all

    @@orders = CSV.read("data/orders.csv").map do |line|
      #order Id from the csv file
      id = line[0].to_i

      # product and prices from the csv spliting a string and creating a hash of products
      items = line[1].split(/[;:]/)
      temp_products = Hash[*items]
      products = Hash[temp_products.map {|item, price| [item, price.to_f]}]

      # customer id from order making an instance of customer
      customer = Customer.find(line[2].to_i)

      # order status from csv and converting string into a symbol
      fulfillment_status = line[3].to_sym

      Order.new(id, products, customer, fulfillment_status)
    end

    return @@orders
  end

  # finding an order with an id paramenter
  def self.find(id)
    orders = self.all
    orders.find {|order| id == order.id}
  end

end
