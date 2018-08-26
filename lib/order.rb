require 'pry'
require 'awesome_print'
require_relative '../lib/customer'

# Create a class called `Order`.
class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  # When I changed products parameter to products = {} and @ products
  # to @products = products I get an error
  # Think it's linked to customer somehow, when I add customer,
  # The error occurs/works without customer
  # When I moved customer to the end, it's fine...why?
  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id
    @products = products
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

    def total
      # Return 0 if empty
      if products.length == 0
        return 0
      else
        # Summing products
        sum = products.values.reduce(:+)
        # Calculating tax
        tax = sum * 0.075
        # Returning total
        return (sum + tax).round(2)
      end
    end

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
        # Create a new order instance for each item
        # id
        id = item["id"].to_i

        # customer - return instance of customer
        customer = Customer.find(item["customer"].to_i)
        # fulfillment status
        status = item["status"].to_sym

        # Creating empty hash to hold product key/value pairs
        product_hash = {}
        # Splitting products by ;
        item["products"].split(";").map do |pair|
            # Splitting each product by :
            item = pair.split(":")
            # Adding item as key and dollar value as value
            product_hash[item[0]] = item[1].to_f
        end
          products = product_hash
          Order.new(id, products, customer, status)
      end



       # item["customer"] = Customer.find(item["customer"].to_i)
       # item["fulfillment_status"] = item["fulfillment_status"].to_sym
       # return data
    end
    #

    #     ######## DO THIS #####################################
    #   # TODO # Create array of orders from array of order hashes
    #     # EACH hash = Create a new instance CUSTOMER class
    # #   order_array = data.map do |order|
    # #    # Using CSV hashes for Customer values
    # #     Order.new(id = order["id"].to_i, products = order["products"],
    # #       customer = order["customer"], fulfillment_status = order["fulfillment_status"]
    # #      )
    # #   end
    # #   return order_array
    # # end
    #
    #
    # end

    # self.find(id) - Returns an instance of Customer where values
      # in id field in the CSV match the passed parameter
    def self.find(id)
      # Returns customer if id is found
      return self.all.find { |order| order.id == id }
    end


end


address = {
  street: "123 Main",
  city: "Seattle",
  state: "WA",
  zip: "98101"
}
cassy = Customer.new(123, "a@a.co", address)
pending_order = Order.new(123, {}, cassy)
paid_order = Order.new(123, {"banana" => 1.99, "cracker" => 3.00}, cassy, :paid)

binding.pry
