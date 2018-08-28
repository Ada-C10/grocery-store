require_relative 'Customer'
require 'pry'

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

  ##########################
  #WAVE 2 (incomplete)
  #########################

  ########################
  # Grocery Store Homework status:
  ##### In addition to working on passing ALL test for Wave#1
  ##### I will also need to continue working on this method as it is not completed.
  ##### Lastly, the conflict with my 'require file' needs to be cleared up.

  # def self.all?
  #   orders = {}
  #   orders  << Order.new(id, products,customer_id,fulfillment_status)
  #   CSV.read("/Users/ada/ada/Projects/grocery-store/data/orders.csv")
  #   id = row[0].to_i
  #   products = {name:price ; nextname:nextprice}
  #   products_array = row[1].split(";")
  #
  #   products_array.each do |item|
  #     name , price = item.split(';')
  #     products[name] = price.to_f
  #     customer_id = row [].to_i
  #     fulfillment_status = row [-1].to_s
  #   end
  #   orders << Order.new(id, products)
  #
  #   return orders
  #
  # end


end
