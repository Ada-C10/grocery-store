require 'csv'
require 'awesome_print'

# class includes attributes of id, products, customer & fulfillment status
class Order
  # class variable defined
  @@orders = []

  # method initializes instance variables
  def initialize(id, products, customer, fulfillment_status = :pending)
        @id = id
        if products.keys == {}
          @products = 0
        end
        @products = products
        @customer = customer
        if fulfillment_status != :pending && fulfillment_status != :paid && fulfillment_status != :processing && fulfillment_status != :shipped && fulfillment_status != :complete
          raise ArgumentError, "No status provided"
        else
          @fulfillment_status = fulfillment_status
        end
        @@orders << self
  end
  attr_reader :id, :products, :customer, :fulfillment_status

  # calculates total amount based on order
  def total
    array = @products.values
    if array != []
      tally = array.reduce(:+)
      tally += (0.075 * tally)
      return tally.round(2)
    else
      return 0
    end
  end

  # helps add a product to order
  def add_product(product_name, price)
    if (@products).include?(product_name)

      raise ArgumentError, "This item has already been added"
    end
    @products["#{product_name}"] = price
  end

  # returns list of all order instances
  def self.all
    return @@orders
  end

  # helps find instance by searching with id
  def self.find(id)
    if id < 1 || id > 101
      return nil
    end
    working_array = Order.all
    working_array.each do |ord|

    if ord.id == id
      return ord
    end
    end
  end
end

# creates instaces based on input from csv file
CSV.open("data/orders.csv",'r').map do |line|
  id = line[0].to_i
  products = line[1]
  array = products.split(';')
  hash = {}
    array.each do |item|
      hash ["#{item.split(':').first}"] = (item.split(':').last).to_f
    end
  products = hash
  customer = Customer.find(line[2].to_i)
  fulfillment_status = line[3].to_sym
  Order.new(id, products, customer, fulfillment_status)
end
