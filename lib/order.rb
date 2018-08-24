require 'pry'
require_relative '../lib/customer'

# Create a class called `Order`.
class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending )
    @id = id
    @products = {}
    @customer = customer

    # Setting fulfilmment options
    fulfillment_options = [:pending, :paid, :processing, :shipped, :complete]
    # Checking if fulfillment_option is valid
    if fulfillment_options.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "Please enter a valid fulfillment status"
    end
  end
end

address = {
  street: "123 Main",
  city: "Seattle",
  state: "WA",
  zip: "98101"
}

cassy = Customer.new(123, "a@a.co", address)
# #
order = Order.new(123, {}, cassy, :paid)
# empty = Order.new(3, {}, cassy)
# invalid = Order.new(3, {}, cassy, "garbage")
# #Each new Order should include the following attributes:
# - ID, a number (read-only)
# - A collection of products and their cost.
#This data will be given as a hash that looks like this:
#     { "banana" => 1.99, "cracker" => 3.00 }
#     ```
#     - Zero products is permitted (an empty hash)
#     - You can assume that there is **only one** of each product
# - An instance of `Customer`, the person who placed this order
# - A `fulfillment_status`, a symbol, one of `:pending`, `:paid`, `:processing`, `:shipped`, or `:complete`
#   - If no `fulfillment_status` is provided, it will default to `:pending`
#   - If a status is given that is not one of the above, an `ArgumentError` should be raised
#
# In addition, `Order` should have:
# - A `total` method which will calculate the total cost of the order by:
#   - Summing up the products
#   - Adding a 7.5% tax
#   - Rounding the result to two decimal places
# - An `add_product` method which will take in two parameters, product name and price, and add the data to the product collection
#   - If a product with the same name has already been added to the order, an `ArgumentError` should be raised




### Optional:
# Make sure to write tests for any optionals you implement!
# - Add a `remove_product` method to the `Order` class which will take in one parameter,
# a product name, and remove the product from the collection
#   - If no product with that name was found, an `ArgumentError` should be raised
