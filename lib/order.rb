require_relative 'customer'
require 'awesome_print'
# ID, a number (read-only)
# A collection of products and their cost. This data will be given as a hash that looks like this:
# { "banana" => 1.99, "cracker" => 3.00 }
# Zero products is permitted (an empty hash)
# You can assume that there is only one of each product
# An instance of Customer, the person who placed this order
# A fulfillment_status, a symbol, one of :pending, :paid, :processing, :shipped, or :complete
# If no fulfillment_status is provided, it will default to :pending
# If a status is given that is not one of the above, an ArgumentError should be raised
# A total method which will calculate the total cost of the order by:
# Summing up the products
# Adding a 7.5% tax
# Rounding the result to two decimal places
# An add_product method which will take in two parameters, product name and price, and add the data to the product collection
# If a product with the same name has already been added to the order, an ArgumentError should be raised
# Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
# If no product with that name was found, an ArgumentError should be raised

class Order

  attr_reader :id
  attr_accessor :fulfillment_status, :customer, :products

  def initialize(id, products, customer, fulfillment_status = :pending)

    @id = id
    @products = products
    @customer = customer

    case fulfillment_status #fulfillment_status special cases
      when ""
        @fulfillment_status = :pending
      when :paid, :processing, :shipped, :complete, :pending
        @fulfillment_status = fulfillment_status #keep status
      else
        raise ArgumentError
    end

  end

  def total
    if @products == nil #if hash is empty
      return 0
    else
      total = @products.sum {|k, v| v} #sum of value in keys
      total_plus_tax = (total * 0.075) + total #multiply by 7.5%
      return total_plus_tax.round(2) #two decimal places
    end
  end

  def add_product(product_name, price)
    if @products[product_name] #if there is a key in product with same name
      raise ArgumentError
    else
      @products[product_name] = price #else new key with price value
    end
  end

end

# products = { "banana" => 1.99, "cracker" => 3.00 }
# order = Order.new(1337, products, "customer")
#
# order.add_product("salad", 4.25)
#
# ap products
# ap order.fulfillment_status
#
# order.add_product("salad", 4.25)
# ap products
#
# ap products
# ap order.total


















#
