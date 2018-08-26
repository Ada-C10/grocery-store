require_relative "customer"

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
end

# ID = 123
# EMAIL = "a@a.co"
# ADDRESS = {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# }
#
# products = { "banana" => 1.99, "cracker" => 3.00 }
#
# customer = Customer.new(ID, EMAIL, ADDRESS)
# order = Order.new(1337, products, customer)
#
#
# puts order.total
