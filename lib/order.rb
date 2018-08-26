require 'csv'
require 'pry'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@all_orders = []

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products # hash of products and costs
    @customer = customer
    @fulfillment_status = fulfillment_status

    @fulfillment_options = [:pending, :paid, :processing, :shipped, :complete]

    unless @fulfillment_options.include? @fulfillment_status
      raise ArgumentError, 'Fulfillment status must be :pending, :paid, :processing, :shipped, or :complete. '
    end # end of Argument Error unless
  end # end of def initialize

  # Calculate total of Order instance products
  def total
    # if @products.empty?
    if @products == {} || @products == 0
      @product_sum = 0
    else
      # @product_sum = @products.values.sum
      total = 0
      @products.each_value do |value|
        total += value
        @product_sum = (total * 1.075).round(2)
      end
    end

    return @product_sum
  end # end of def total

  # Add product to this instance of Order
  def add_product(product_name, product_price)
    if @products.include? product_name
      raise ArgumentError, "Product is already on product list."
    else
      @products[product_name] = product_price
    end
  end # end of def add_product

  def add_to_orders
    @@all_orders << self
  end

  def self.all
    @@all_orders
  end

end # end of class Order # why unexpected??

CSV.open("data/orders.csv", 'r').each do |line|
  # line = ["1", "Lobster:17.18;Annatto seed:58.38;Camomile:83.21","25","complete"]
  id = line[0] # id = "1"

  products_string = line[1]
  # products_string =  "Lobster:17.18;Annatto seed:58.38;Camomile:83.21"
  products_string_array = products_string.split(";")
  # = ["Lobster:17.18", "Annatto seed:58.38", "Camomile:83.21"]

  product_hash = {}

  products_string_array.each do |product|
  # product = "Lobster:17.18"
    ind = product.split(":")
    # ind = ["Lobster", "17.18"]
    # product_hash = {ind[0] => (ind[1].to_f)} # only has one?
    product_hash[ind[0]] = (ind[1].to_f)

# binding.pry


  # products_string_array.map do |product|
  #   ind = product.split(":")
    # => [["Lobster", "17.18"],
 #      ["Annatto seed", "58.38"],
 #      ["Chamomile", "83.21"]]

      # product.each do |arr|
      #   arr.each do |ar|
      #     product_hash[ar[0]] = [ar[1]]
      #   end
      # end

  end


  new_order = Order.new(id, product_hash, line[2], line[3].to_sym)

  # order = Order.new(line[0], products, line[2], line[3].to_sym)
  new_order.add_to_orders
end
