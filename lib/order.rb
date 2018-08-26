# require_relative "customer"

class Order

  attr_reader :id
  attr_accessor :customer, :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError if ![:pending, :paid, :processing, :shipped, :complete].include? (fulfillment_status)
    @id = id
    @products = products #give as a hash with name of item and price ("banana" => 1.99)
    @customer = customer # person who placed the order.  An instance of customer class
    @fulfillment_status = fulfillment_status

  end

  def total
    if @products == {}
      return 0
    else
      total = 0
      @products.each do |key, value|
        total = value + total
      end
      return (total + (total * 0.075)).round(2)
    end
  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError
    else
      return @products[product_name] = price
    end
  end

end


# customer = Customer.new(123, "a@a.co", {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# })
# #
# # # 1. how link this data from the customer class to this class?  Through the main?
# #
# order = Order.new(1337, {}, customer)
# puts order.id
# puts order.products
# puts order.customer
# puts order.fulfillment_status
