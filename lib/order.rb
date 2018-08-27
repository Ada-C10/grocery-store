require_relative './customer'

# define class to track invidual orders
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  # initialize Order instances
  def initialize(id, products, customer, fulfillment_status = :pending)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    raise ArgumentError.new, "Not a valid fulfillment status" unless [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)

  end

  # define method to find total cost including tax
  def total
    total = 0

    # find subtotal
    @products.each do |product, price|
      total += price
    end

    # calculate and add sales tax
    total += (total * 0.075)

    # round final total to 2 decimal places
    total = total.round(2)

    return total

  end

  # define method to add a product to the collection of @products for this order
  def add_product(product_name, price)

    raise ArgumentError.new, "That product has already been added" if @products.key?(product_name)

    @products[product_name] = price

  end

  # define method to remove a product from the @products collection for this order
  def remove_product(product_name)

    raise ArgumentError.new, "That product does not exist in this order" unless @products.key?(product_name)

    @products.delete(product_name)

  end

  # define method to read CSV data and return an array of Customer instances
  def self.all
    # create array
    orders = []

    # read CSV file
    data = CSV.read("data/orders.csv")

    # parse CSV data and pass to Customer instance
    data.each do |order|
      id = order[0].to_i
      products = parse_products(order[1])
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym

      orders << Order.new(id, products, customer, fulfillment_status)
    end

    return orders
  end

  # define method to find an order by its ID number
  def self.find(id)
    return Order.all.detect { |order| order.id == id }
  end

  # define method to find an individual customer via their ID number
  def self.find_by_customer(customer_id)
    return self.all.find_all { |order| order.customer.id == customer_id }
  end

end


# define method to parse CSV products into hash
def parse_products(products)
  products = products.split(';')

  product_hash = {}

  products.each do |product|
    product = product.split(':')

    product_hash[product[0]] = product[1].to_f
  end

  return product_hash
end
