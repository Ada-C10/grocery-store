require "pry"
require "csv"
require_relative "customer"

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
    all_orders = CSV.open(ORDERS_FILENAME, "r").map do |line|
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

# TODO:
# put csv parsing stuff in separate method.
# both Order and Customer classes use a lot of the same stuff. can I mixin?
#
# OLD SELF.ALL CODE BEFORE REFACTOR
#
# # write a new copy of CSV with headers if it doesn't already exist
# unless File.exist?(ORDERS_FILENAME_HEADERS)
#   headers = [:order_id, :products, :customer_id, :status]
#   new_csv = CSV.read(ORDERS_FILENAME_NO_HEADERS).unshift(headers)
#   CSV.open(ORDERS_FILENAME_HEADERS, "w", headers: headers) { |f|
#     new_csv.each { |a| f << a }
#   }
# end
#
# # import CSV with headers as array of hashes
# imported_csv = CSV.read(ORDERS_FILENAME_HEADERS, headers: true,
#                         :header_converters => :symbol,
#                         :converters => :integer).map{ |r| r.to_h}
# # [{:order_id=>1, :products=>"Lobster:17.18;Annatto seed:58.38;
# # Camomile:83.21", :customer_id=>25, :status=>"complete"}, ... etc. ]
#
# # parse [:products] to Hash
# imported_csv.map do |h| # make this a sep method
#   str = h[:products].gsub(/:/, ";")
#   arr = str.split(";")
#   # convert every other array element (price) to float
#   arr = arr.map.with_index { |v,i| i%2 == 1 ? v.to_f : v }
#   hsh = Hash[*arr]
#   h[:products] = hsh
#   h[:status] = h[:status].to_sym
# end
# # [{:order_id=>1, :products=>{"Lobster"=>17.18, "Annatto seed"=>58.38,
# # "Camomile"=>83.21}, :customer_id=>25, :status=>"complete"}, ... etc. ]
#
# # make new Order instances and collect in all_orders Array
# imported_csv.each do |h|
#   id = h[:order_id]
#   products = h[:products]
#   customer = Customer.find(h[:customer_id])
#   fulfillment_status = h[:status]
#   all_orders << Order.new(id, products, customer, fulfillment_status)
# end
#
# return all_orders
#[#<Order:0x00007fbfc995f958 @id=1, @products={"Lobster"=>17.18,
# "Annatto seed"=>58.38, "Camomile"=>83.21},
# @customer=#<Customer:0x00007fbfc99603d0 @id=25, @email="summer@casper.io",
# @address={:address_1=>"66255 D'Amore Parkway", :city=>"New Garettport",
# :state=>"MO", :zip_code=>57138}>, @fulfillment_status=:complete>, ... ]
# end
