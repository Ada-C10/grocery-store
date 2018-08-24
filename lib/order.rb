require_relative 'customer'
require 'pry'
require 'csv'

def parse_data(data)
  # convert product string to hash
  new_data = data.map do |element|
    [element[0], element[1].split(';').map { |i| i.split ':' }.to_h, element[2], element[3]]
  end
  # convert remaining fields to required data type
  new_data = new_data.map do |e|
    [e[0].to_i, e[1].each { |k,v| e[1][k] = v.to_i }, e[2].to_i, e[3].to_sym]
  end
  ap new_data
end

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    if valid_status.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, 'Fulfillment status is not valid'
    end
  end

  def total
    subtotal = @products.sum { |product_name, price| price }
    return total_cost = (subtotal * 1.075).round(2)
  end

  def add_product(product_name, price)
    if @products.keys.include?(product_name)
      raise ArgumentError, 'Product has already been added to the order'
    else
      return @products[product_name] = price
    end
  end

  def remove_product(product_name)
    if @products.keys.include?(product_name)
      return @products.reject! { |k| k == product_name }
    else
      raise ArgumentError, 'No product with that name exists in the current order'
    end
  end

  def self.all
    orders_raw_data = CSV.read('data/orders.csv')
    parse_data(orders_raw_data)
    # returns a collection of Order instances, representing all of orders from CSV
  end

  def self.find(id)
    # returns an instance of Order with ID
    # invokes self.all
  end

  def find_by_customer(customer_id)
    # returns a list of Order instances matching customer's ID
  end

end
# address = {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# }
# customer = Customer.new(123, "a@a.co", address)
# id = 1337
# fulfillment_status = :shipped
# order = Order.new(id, {}, customer, fulfillment_status)
# binding.pry
Order.all
