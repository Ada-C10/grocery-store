require_relative 'Customer'
require 'pry'
require 'csv'

#####################
#WAVE 1
#####################

# Create a Order class with with 4 attributes.

class Order
  attr_reader :id, :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    # Fulfillment status will default to pending if no status is given
    # An ArgumentError is raised when fulfillment_status isn't matching any options
    if [:pending,:processing,:shipped,:paid,:complete].include? fulfillment_status
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end
  end

  # Total method calculate the total cost of the order
  def total
    total = 0
    @products.each do |product,cost|
      total += cost
    end
    return total += (0.075 * total).round(2) #add 7.5 tax and rounding to 2 decimal places
  end

  # Add method which will take 2 parameters and add data to the product collection
  def add_product(product,cost)
    if @products.key?(product)
      raise ArgumentError.new("The product is already present")
    else
      @products[product] = cost
      return true
    end
      #Raise ArgumentError when products is of the same name already added
      # --> This test is failing - reviewing syntax and order of my if statemen
  end

  #########################
  # WAVE 2 (incomplete)
  ########################

  # #######################
  # Grocery Store Homework status:
  # #### In addition to working on passing ALL test for Wave#1
  # #### I will also need to continue working on this method as it is not completed.
  # #### Lastly, the conflict with my 'require file' needs to be cleared up.

  def self.all
    data = CSV.read("/Users/ada/ada/Projects/grocery-store/data/orders.csv")# content from my entire CSV File
    orders = []
    data.each do |row_data| #one line from CSV
      orderID = row_data[0]
      products = row_data[1]
      products_prices  = products.split(';')

      products_hash = {}
      products_prices.each do |product_price|
        product_and_price = product_price.split(':')
        product_name = product_and_price[0]
        product_cost = product_and_price[1]
        products_hash[product_name] = product_cost
      end

      customer_id = row_data[2]
      customer = Customer.find(customer_id)
      fulfillment_status = row_data[3].to_sym
      order = Order.new(orderID, products, customer, fulfillment_status)
      orders << order
    end
    return orders
  end

end
