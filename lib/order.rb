require_relative "customer"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id #<-- int
    @products= products #<-- hash
    @customer = customer #<-- object (Customer)
    @fulfillment_status = check_fulfillment_status(fulfillment_status) #<-- symbol
  end

  # check whether a valid fulfillment status was entered
  # if not, raise exception
  def check_fulfillment_status(fulfillment_status)
    case fulfillment_status
    when :pending, :paid, :processing, :shipped, :complete
      return fulfillment_status
    else
      return raise ArgumentError, "This is not a recognized fulfillment status."
    end
  end

  # find total cost of an order
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

  # add product to an order
  # if it's a duplicate, raise exception
  def add_product(name, price)
    if @products.include? name
      raise ArgumentError, "This product has already been added to the order."
    else
      @products[name] = price
    end
  end

  # remove product from an order
  # if product doesn't exist in the order, raise exception
  def remove_product(product_name)
    if @products.keys.include? product_name
      return @products.delete_if {|product| product == product_name}
    else
      return raise ArgumentError, "There are no products by that name to remove."
    end
  end

  # return a hash of products from csv file string
  def self.create_products_hash(products_input)
    products = {}

    products_input.split(";").each do |items|
      items = items.split(":")
      key = items[0]
      value = items[1]
      products[key] = value.to_f
    end

    return products
  end

  # instantiate each row in csv as new Order instances
  # returns an array with each Order object
  def self.all()
    file = "data/orders.csv"

    all_orders = CSV.open(file, 'r').map do |line|

      id = line[0].to_i
      products = create_products_hash(line[1])
      customer = Customer.find(line[2].to_i)
      fulfillment_status = line[3].to_sym

      new_order = self.new(id, products, customer, fulfillment_status)
    end

    return all_orders
  end

  # find and return instance of Order based on id
  # if id does not exist, return nil
  def self.find(id)
    orders = self.all
    return orders.find { |order| order.id == id }
  end

  # find and return instance of Order based on Customer id
  # if Customer id does not exist, return nil
  def self.find_by_customer(customer_id)
    orders = self.all
    order_matches = orders.find_all { |order| order.customer.id == customer_id }

    if order_matches.length > 0
      return order_matches
    else
      return nil
    end
  end
end
