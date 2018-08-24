require_relative 'customer'
require 'csv'
require 'pry'

def products_costs(string)
  products_costs = {}
  remove_semi_colon = string.split(";")
  remove_colon = remove_semi_colon.map do |i|
    i.split(":")
  end
  remove_colon.flatten!
  products_w_floats = remove_colon.map do |item|
    if item =~ /[[:digit:]]/ then item.to_f else item end
  end
  products_w_floats.length.times do |i|
    products_costs[products_w_floats[i]] = products_w_floats[i + 1]
    products_w_floats.delete(products_w_floats[i])
  end
  products_costs.delete(nil)
  return products_costs
end

class Order
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    if fulfillment_status != :pending && fulfillment_status != :paid && fulfillment_status != :processing  && fulfillment_status != :shipped && fulfillment_status != :complete
      raise ArgumentError, 'Status must be: :pending, :paid, :processing, :shipped, :complete'
    else
      @fulfillment_status = fulfillment_status
      @fulfillment_status ||= :pending
    end
  end

  attr_reader(:id, :products,:customer, :fulfillment_status, :total)

  def total
    sum = products.values.sum
    percent = sum * 0.075
    return @total = ("%.2f" % (sum + percent)).to_f
  end

  def add_product(name, price)
    if @products.keys.include?(name)
      raise ArgumentError, 'A product with the same name has already been added to the order'
    else
      return products[name] =  price
    end
  end

  def remove_product(product_name)
    if @products.keys.include?(product_name)
      @products.delete_if {| name, price | name.include?(product_name) }
    else
      raise ArgumentError, 'This product has not been found'
    end
  end

  @@order = []
  def self.all
    @@order = CSV.open('data/orders.csv', 'r', headers: false).map do |line|
      products_costs = products_costs(line[1])

      customers = Customer.all
      customers.each { |customer| if customer.id == line[2].to_i then @customer = customer end }

      self.new(line[0].to_i, products_costs, @customer, line[3].to_sym)
    end
    return @@order
  end

  def self.find(id)
    orders = Order.all
    @found = nil
    orders.each { |item| if item.id.to_i == id then @found = item end }
    return @found
  end

  def self.find_by_customer(customer_id)
    order_list = Order.all
    orders = []
    order_list.each { |purchase| if customer_id == purchase.customer.id.to_i then orders << purchase end }
    return orders
  end

end
