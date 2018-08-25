require 'pry'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  @@valid_statuses = %i[pending paid processing shipped complete] # array of keys
  @@orders = []
  #order = Order.new(1337, products, customer)
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    #check_valid(@fulfillment_status)
  end

  def check_valid(bogus_status)
      if @@valid_statuses.include?(bogus_status)

      else
        raise ArgumentError, "bogus status!"
      end
  end
  # products = { "banana" => 1.99, "cracker" => 3.00 }
  def total
    prices = @products.values
    total = prices.sum
    total_and_tax = total * 0.075 + total
    total_and_tax = total_and_tax.round(2)
    if total_and_tax == 0.0
      return 0
    else
      return total_and_tax
    end
  end
# order.add_product("salad", 4.25)
  def add_product(key, value)
    if @products.include?(key)
      raise ArgumentError
    end
    @products[key] = value
  end

  #  order = Order.new(1, {}, customer, fulfillment_status)
  #  [["1", #id
  # "Lobster:17.18;Annatto seed:58.38;Camomile:83.21", #products
  # "25", #customer
  # "complete"] # fulfillment_status
  # id, products, customer, fulfillment_status
  def self.products_into_hash(string)
    products_hash = {}
    items = string.split(";")
    items.each do |item|
      key = item.split(":").first
      value = item.split(":").last.to_f
      products_hash[key] = value
    end
    return products_hash
  end

  def self.all
    @@orders = CSV.read('data/orders.csv').map {|line| line}
    @@orders = @@orders.map do |array|
      Order.new(id = array[0].to_i, products = self.products_into_hash(array[1]), customer = Customer.find(array[2].to_i), fulfillment_status = array[3].to_sym)
    end
    return @@orders
  end

  def self.find(id)

  end

end
