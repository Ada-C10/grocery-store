require "pry"
require "csv"
require_relative "customer"
require "awesome_print"

ORDERS_FILENAME = "data/orders.csv"

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  # Integer, Hash, Class::Customer, Symbol
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products # { "banana" => 1.99, "cracker" => 3.00 }
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]
    unless valid_statuses.include?(@fulfillment_status)
      raise ArgumentError, ":fulfillment_status is invalid. Try: " \
                           "[:pending (default), :paid, :processing, " \
                           ":shipped, :complete]"
    end
  end

  def total
  # calculate total cost of order from @products hash
    subtotal = @products.values.sum
    return total = (subtotal*1.075).round(2)
  end

  # string, float/integer
  def add_product(product_name, price)
    if @products.keys.include?(product_name)
      raise ArgumentError, "Your order already has a product with this name."
    end
    return @products[product_name] = price
  end

  def remove_product(product_name)
    return @products.delete(product_name) { raise ArgumentError, "There isn't" \
                                            " a product with that name in " \
                                            "your order."
                                          }
  end

  def self.all
  # return a collection of Orders from CSV
    return all_orders = CSV.open(ORDERS_FILENAME).map do |line|
        (0..3).each do |i|
          line[i] = line[i].upcase
        end
        self.new(line[0].to_i, self.find_products(line[1]),
        Customer.find(line[2].to_i), line[3].to_sym)

    end
  end

  def self.find_products(products_string)
    # products is a String, like "Lobster:17.18;Annatto seed:58.38;Camomile:83.21"
    # call once for every line of CSV in self.all
    # return hash, parsed
    # { "banana" => 1.99, "cracker" => 3.00 }
    parsed_products_hash = {}
    product_pair_array = products_string.split(";")
    product_pair_array.each do |pair|
      single_pair_array = pair.split(":")
      parsed_products_hash[single_pair_array[0]] = single_pair_array[1].to_f
    end
    return parsed_products_hash
  end

  def self.find(id)
  # return instance of Order where id = id
  # return nil if none found
    all_orders = self.all
    return all_orders.find{|obj| obj.id == id}
  end

  def self.find_by_customer(customer_id)
  # return a list of Order instances where the value of the customer's ID
  # matches the passed parameter.
  # return nil if no matching orders are found.
    all_orders = self.all
    orders_by_customer = all_orders.select do |obj|
      obj.customer.id == customer_id
    end
    return orders_by_customer.empty? ? nil : orders_by_customer
  end
end
