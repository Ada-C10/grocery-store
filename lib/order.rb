require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@customer_orders = []

  VALID_FULFILLMENTS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer,  fulfillment_status = :pending)

    if !VALID_FULFILLMENTS.include?(fulfillment_status)

      raise ArgumentError.new("Not a valid status")
    end

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    sum = @products.reduce(0) do |total,(item, cost)|

      total + cost
    end

    return ((sum + sum * 0.075) * 100).round / 100.0
  end


  def add_product(product_name, price)

    if @products.has_key?(product_name)
      raise ArgumentError.new("Adding product that already exists")

    else

      @products["#{product_name}"] = price
    end
  end

  #OPTIONAL WAVE 1
  def remove_product(product_name)

    if !(@products.has_key?(product_name))

      raise ArgumentError.new("Can't remove product that does not exist.")
    end

    @products.delete(product_name)
  end

  def self.all
    orders = CSV.open('data/orders.csv', "r+").map do |order|

      #split order[1] into each then loop through to create product hash: product => price
      products = order[1].split(";")
      split_products_hash = {}

      products.each do |product|

        split_product = product.split(":")
        split_products_hash[split_product[0]] = split_product[1].to_f
      end

      #pass in split product hashes, etc to instantiate
      Order.new(order[0].to_i, split_products_hash, Customer.find(order[-2].to_i), order[-1].to_sym)
    end

    return orders
  end

  def self.find(id)
    @@orders ||= Order.all

    found_order = @@orders.find do |order|

      order.id == id
    end

    return found_order
  end

  def self.find_by_customer(customer_id)
    @@orders ||= Order.all

    customer_orders = @@orders.find_all do |order|

      customer_id == order.customer.id
    end

    if customer_orders.empty?
      raise ArgumentError.new("Customer doesn't exist")
    end

    return customer_orders
  end

  #EXTRA METHOD that prints extra info if needed instead of returning array
  def self.print_list_of_customer_orders(customer_id)

    customer_orders = Order.find_by_customer(customer_id)

    if customer_orders.empty?
      raise ArgumentError.new("Customer doesn't exist")
    end

    start_statement = "Customer with id #{customer_orders[0].customer.id} and email #{customer_orders[0].customer.email} has ordered the following: "

    return customer_orders.reduce(start_statement) do |return_statement, customer_order|

      return_statement + "\n" + "Order id " + "#{(customer_order.id)} with #{customer_order.products.keys.join(', ')}"
    end
  end
end
