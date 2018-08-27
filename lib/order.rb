require 'csv'
require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@all_orders = []

  # Constructor method to initialize all Order.new instances
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    # Raise ArgumentError if fulfillment_status is not one of five options
    @fulfillment_options = [:pending, :paid, :processing, :shipped, :complete]
    unless @fulfillment_options.include? @fulfillment_status
      raise ArgumentError, 'Fulfillment status must be :pending, :paid, :processing, :shipped, or :complete. '
    end
  end

  # Calculate total of Order instance products
  def total
    # if @products.empty, product sum is 0
    if @products == {} || @products == 0
      @product_sum = 0
    else
      # @product_sum = @products.values.sum
      total = 0
      @products.each_value do |value|
        total += value
        @product_sum = (total * 1.075).round(2)
      end
    end

    return @product_sum
  end

  # Add product to this instance of Order
  def add_product(product_name, product_price)
    if @products.include? product_name
      raise ArgumentError, "Product is already on product list."
    else
      @products[product_name] = product_price
    end
  end

  # Add Order instance to array of all Order instances
  def add_to_orders
    @@all_orders << self
  end

  # Return arrray of all Order instances
  def self.all
    @@all_orders
  end

  # Find Order by id number
  def self.find(id)
    found_order = nil

    Order.all.each do |order|
      if order.id == id.to_i
        found_order = order
      end
    end

    return found_order
  end

end

# Open CSV file and parse strings for Order instance parameters
CSV.open("data/orders.csv", 'r').each do |line|
  # line = ["1", "Lobster:17.18;Annatto seed:58.38;Camomile:83.21","25","complete"]
  id = (line[0].to_i)

  products_string = line[1]
  # products_string =  "Lobster:17.18;Annatto seed:58.38;Camomile:83.21"
  products_string_array = products_string.split(";")
  # = ["Lobster:17.18", "Annatto seed:58.38", "Camomile:83.21"]

  product_hash = {}

  products_string_array.each do |product|
  # product = "Lobster:17.18"
    ind = product.split(":")
    # ind = ["Lobster", "17.18"]
    product_hash[ind[0]] = (ind[1].to_f)
  end

  customer = Customer.find(line[2].to_i)

  new_order = Order.new(id, product_hash, customer, line[3].to_sym)

  new_order.add_to_orders
end
