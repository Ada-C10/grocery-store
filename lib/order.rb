# require_relative "customer"

class Order

  attr_reader :id
  attr_accessor :customer, :products, :fulfillment_status



  def initialize (id, products, customer, fulfillment_status: :pending)

    @id = id
    @products = products #give as a hash with name of item and price ("banana" => 1.99)
    # an empty products hash is permitted, meaning nothing for sale
    # assume only one of each product
    @customer = customer # person who placed the order.  An instance of customer class
    @fulfillment_status = fulfillment_status

  end

  def total (products)
    if products = {}
      return 0
    else
      total = 0
      products.each do |key, value|
        total = value + total
      end
      return (total + (total * 0.075)).round(2)
    end
  end



  def add_product (product_name, price)
    products = {
      "Lobster" => 17.18,
      "Annatto seed" => 58.38,
      "Camomile" => 83.21
    }
    products[product_name] = price
    return products
  end

  add_product("banana", 7)



    # add the data in the parameters to the @products
    # raise argument if product of the same name has already been added

  def bogus_statuses (fulfillment_status)
    unless fulfillment_status == :pending || fulfillment_status == :paid || fulfillment_status == :processing || fulfillment_status == :shipped || fulfillment_status == :completed
      raise ArgumentError ("Only fulfillment status options are :pending, :paid, :processing, :shipped, or :completed")
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
