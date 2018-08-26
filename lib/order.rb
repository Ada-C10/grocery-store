require_relative "customer"
require "ap"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id #<-- int
    @products= products #<-- hash
    @customer = customer #<-- class Customer
    @fulfillment_status = fulfillment_status #<-- symbol

    # TODO + QUESTION: make this its own def??
    case @fulfillment_status
    when :pending, :paid, :processing, :shipped, :complete
      return @fulfillment_status
    else
      raise ArgumentError, "This is not a recognized fulfillment_status."
    end

  end

  def total()
    total_cost = 0

    if @products.count == 0
      return 0
    end

    @products.each do |product, cost|

      total_cost += cost

    end

    total_cost += (total_cost * 0.075)
    total_cost = ("%.2f" % total_cost)
    return total_cost.to_f
  end

  def add_product(name, price)
    if @products.include? name
      raise ArgumentError, "This product has already been added to the order."
    else
      @products[name] = price
    end
  end

  def self.create_products_hash(file)
    # index = 0
    # split_products = {}
    # key = ""
    # value = ""
    # all_items= []
    #
    # CSV.open(file, 'r').each do |line|
    #   items = line[1].split(";")
    #
    #     items = items.each { |item| item.split(":")}
    #
    #     key = items[0]
    #     value = items[1]
    #     split_products = {key => value}
    #
    #     end
    #
    #
    #
    # return split_products
  end

  def self.all()
    # TODO: create helper functions here and in customer
    # TODO: WRITE TESTS
    file = "data/orders.csv"


    all_orders = CSV.open(file, 'r').map do |line|
      products = {}

      line[1].split(";").map do |items|
        items = items.split(":")
        key = items[0]
        value = items[1]
        products[key] = value.to_f
        products

      end





    customer = Customer.find(line[2].to_i)

    order_hash = {
      id: line[0].to_i,
      products: products,
      customer: customer,
      fulfillment_status: line[3].to_sym
    }

      new_order = Order.new(order_hash[:id], order_hash[:products], order_hash[:customer], order_hash[:fulfillment_status])

  end
  return all_orders
end

  def self.find(id)

    orders = self.all

    return orders.find { |order| order.id == id }
  end

end

ID = 123
EMAIL = "a@a.co"
ADDRESS = {
  street: "123 Main",
  city: "Seattle",
  state: "WA",
  zip: "98101"
}

products = { "banana" => 1.99, "cracker" => 3.00 }

customer = Customer.new(ID, EMAIL, ADDRESS)
order = Order.new(1337, products, customer)


print Order.all










    # key = product_info[0]
    # value = product_info[1]
    # split_products[key] = value
    # split_products

  #   # info = info.to_h
  #   # holder << info
  #   # holder
  #
  # #






# print holder
# ap split_products





  # #











# print all_products
