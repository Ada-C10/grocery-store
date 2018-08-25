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

    # Setting fulfilmment options
    fulfillment_options = [:pending, :paid, :processing, :shipped, :complete]
    # Checking if fulfillment_option is valid
    # Unsure why test is reaching ArgumentError when it shouldn't
    if fulfillment_options.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "Please enter a valid fulfillment status"
    end
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

    end

    # returns a collection of Order instances,
    # representing all of the Orders described in the CSV file

    def self.all
      # Opening orders.csv
      data = CSV.open("data/orders.csv", headers: true).map do |item|
        # Converting values
        item["id"] = item["id"].to_i
        item["customer_id"] = item["customer_id"].to_i
        item["fulfillment_status"] = item["fulfillment_status"].to_sym
        item.to_h
      end

      # Converting product string to a hash
      data.map do |main_hash|
        # Creating empty hash to hold product key/value pairs
        product_hash = {}
        # Splitting products by ;
        main_hash["products"].split(";").map do |pair|
          # Splitting each product by :
          item = pair.split(":")
          # Adding item as key and dollar value as value
          product_hash[item[0]] = item[1].to_f
        end
        main_hash["products"] = product_hash
      end
      return data
    end
end

address = {
  street: "123 Main",
  city: "Seattle",
  state: "WA",
  zip: "98101"
}

cassy = Customer.new(123, "a@a.co", address)
pending_order = Order.new(123, {}, :pending, cassy)
paid_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, :paid, cassy)

# processing_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, :processing, cassy)
# shipped_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, :shipped, cassy)
# complete_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, :complete, cassy)
# empty_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, cassy)
# invalid_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, "garbage", cassy)

# binding.pry
