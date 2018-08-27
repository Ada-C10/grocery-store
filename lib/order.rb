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

  def check_fulfillment_status(fulfillment_status)
    case fulfillment_status
    when :pending, :paid, :processing, :shipped, :complete
      return fulfillment_status
    else
      return raise ArgumentError, "This is not a recognized fulfillment status."
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

  def remove_product(product_name)
    if @products.keys.include? product_name
      return @products.delete_if {|product| product == product_name}
    else
    return raise ArgumentError, "There are no products by that name to remove."

    end
  end

  def read_file()

  end

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

  def self.find(id)
    orders = self.all
    return orders.find { |order| order.id == id }
  end

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
