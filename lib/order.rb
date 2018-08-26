# allows use of csv file
require 'csv'
# allows access to customer.rb
require_relative 'customer'

# creates Order class
class Order
  # reads data from orders.csv file
  @@order = CSV.read("data/orders.csv")

  # id attribute is read only
  attr_reader :id
  # other attributes can be read and written
  attr_accessor :products, :customer, :fulfillment_status

  # accepts 4 attributes with default status being :pending
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
      # if status doesn't match any of the following
      # it will raise ArgumentError
      if fulfillment_status != :pending &&
        fulfillment_status != :paid &&
        fulfillment_status != :processing &&
        fulfillment_status != :shipped &&
        fulfillment_status != :complete
        raise ArgumentError
      end
  end

  # calculates total price of each order
  def total()
    # sums all costs in one order
    total_cost = products.values.inject(:+).to_f

    # addes tax to the total cost of that order
    total_cost_plus_tax = total_cost + (total_cost * 0.075)
    # returns total cost plus tax
    return total_cost_plus_tax.round(2)
  end

  # adds product and cost if it doesn't exit
  def add_product(new_product, price_of_new_product)
    if products.keys.include?(new_product) == false
      products[new_product] = price_of_new_product

    # if product name already exists, then raise error
    elsif products.keys.include?(new_product) == true
      raise ArgumentError
    end
  end

  # using all of the data in csv,
  # creates instances of Order class using following format
  # then stores it into array
  def self.all
    orders = @@order.map do |order_data|
      online_id = order_data[0].to_i

      # divides the string from the csv file by : or ;
      # creates it into a hash
      products = Hash[*order_data[1].split(/:|;/)]

      # turns costs into a float
      products.each do |product, cost|
        products[product] = cost.to_f
      end

      # creates instance of Customer using customer_data
      # from order.csv file
      customer_id = Customer.find(order_data[2].to_i)

      # turns status into symbol from string
      status = order_data[3].to_sym

      # creates instance of Order class with arguments
      order = Order.new(online_id, products, customer_id, status)
    end

    return orders
  end

  # finds matching id from instances of Order class
  # returns matching instance
  def self.find(id)
    Order.all.select do |online_order|
      if online_order.id == id
        return online_order
      end
    end

    # if there isn't a match, returns nil
    return nil
  end
end
