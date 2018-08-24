require 'pry'
require_relative '../lib/customer'

# Create a class called `Order`.
class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  # When I changed products parameter to products = {} and @ products
  # to @products = products I get an error
  # Think it's linked to customer somehow, when I add customer,
  # The error occurs/works without customer
  # When I moved customer to the end, it's fine...why?
  def initialize(id, products = {}, fulfillment_status = :pending, customer)
    @id = id
    @products = products
    # @customer = customer

    # Setting fulfilmment options
    fulfillment_options = [:pending, :paid, :processing, :shipped, :complete]
    # Checking if fulfillment_option is valid
    # Unsure why test is reaching ArgumentError when it shouldn't
    if fulfillment_options.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      # Errors link to here. Not sure why...
      raise ArgumentError, "Please enter a valid fulfillment status"
    end
    # binding.pry
    @customer = customer
  end

  # Total method
    # Sum the products
    # Add a 7.5% tax
    # Round the result to two decimal places
    def total
      if products.length == 0
        return 0
      else
        sum = products.values.reduce(:+)
        tax = sum * 0.075
        return (sum + tax).round(2)
      end
    end

  # TODO add_product method
    # Takes product_name and price
    # Adds data to product hash
      # If product with same name is already in order,
      # raise an ArgumentError

    def add_product(product_name, price)
      # Adds data to hash
      # If already in hash, raise ArgumentError
      if @products.include?(product_name)
        raise ArgumentError, 'Product has already been added'
      else
        @products[product_name] = price
      end
      # if @products.include?(product_name)
      #   raise ArgumentError, 'That product already exists'
      # else
      #   @products[product_name] => price
      # end
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

# pending paid processing shipped complete
pending_order = Order.new(123, {}, :pending, cassy)
paid_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, :paid, cassy)

# processing_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, :processing, cassy)
# shipped_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, :shipped, cassy)
# complete_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, :complete, cassy)
# empty_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, cassy)
# invalid_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, "garbage", cassy)

# binding.pry



# binding.pry
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



### Optional:
# Make sure to write tests for any optionals you implement!
# - Add a `remove_product` method to the `Order` class which will take in one parameter,
# a product name, and remove the product from the collection
#   - If no product with that name was found, an `ArgumentError` should be raised
