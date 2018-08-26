require_relative 'customer'
require 'csv'
require 'pry'

# Wave 1 order class creations

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  @@orders = []

  def initialize(id, products, customer, fulfillment_status = :pending)
    # refractor later: use turnery here to raise the argument
    # [:pending, :paid, :processing, :shipped,  :complete].include?fulfillment_status ? @fulfillment_status = fulfillment_status : raise ArgumentError

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

  # Tally the total and return total cost with tax calculated
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

    return total.round(2)
  end

  # optional - removal of products
  # method would take in one paramenter (name of product) and be able to remove it
  # if product doesn't exist in the collection raise an ArgumentError

  # Wave 2
  # creating a global varaible outside the class to be called in in the class above to load the data ones

  # def save
  #   @@orders << self
  # end

  def self.all

  @@orders = CSV.read("data/orders.csv").map do |line|
      #order Id from the csv file
      id = line[0].to_i

      # product and prices from the csv spliting a string and creating a hash of products
      items = line[1].split(/[;:]/)
      temp_products = Hash[*items]
      products = Hash[temp_products.map {|item, price| [item, price.to_f]}]

      # customer id from order making an instance of customer
      customer_id = line[2].to_i
      customer = Customer.find(customer_id)
        # customer = Customer.find(line[2].to_i)

      # order status from csv and converting string into a symbol
      fulfillment_status = line[3].to_sym

      Order.new(id, products, customer, fulfillment_status)
    end
    return @@orders
  end


  def self.find(id)
    orders = self.all
    orders.find {|order| id == order.id}

  #   @@orders.each do |order|
  #     if order.id == id_inputted
  #       return order
  #     end
  #   end
  #   return nil
  end
end



# # creating a global varaible outside the class to be called in in the class above to load the data ones
#
# CSV.read("data/orders.csv").map do |line|
#   #order Id from the csv file
#   id = line[0].to_i
#
#   # product and prices from the csv spliting a string and creating a hash of products
#   items = line[1].split(/[;:]/)
#   temp_products = Hash[*items]
#   products = Hash[temp_products.map {|item, price| [item, price.to_f]}]
#
#   # customer id from order making an instance of customer
#   # customer = line[2].to_i
#   # customer = Customer.find(customer_id)
#   customer = Customer.find(line[2].to_i)
#
#   # order status from csv and converting string into a symbol
#   fulfillment_status = line[3].to_sym
#
#   order = Order.new(id, products, customer, fulfillment_status)
#   order.save
# end
