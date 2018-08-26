class Order

  require 'csv'

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status


  VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]


  # Instance Methods
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    unless VALID_STATUSES.include? (fulfillment_status)
      raise ArgumentError
    end
  end


  def total
    subtotal = @products.values.sum
    tax = 0.075

    total = subtotal + (subtotal * tax)

    return total.round(2)
  end


  def add_product(product, price)
    @products.keys.include?(product) ? raise(ArgumentError) : @products[product] = price
  end


  def remove_product(product)
    @products.keys.include?(product) ? @products.delete(product) : raise(ArgumentError)
  end


  # Class Methods
  def self.all
    orders = []

    CSV.read('data/orders.csv').each do |order|

      id = order[0].to_i
      products = FormatData.parse_to_hash(order[1])
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym

      orders << Order.new(id, products, customer, fulfillment_status)
    end

    return orders
  end


  def self.find(id)
    orders = Order.all

    orders.find do |order|
      order.id == id
    end
  end

end


# Helper Methods
module FormatData
  def self.parse_to_hash(string)
    hash = {}

    string.split(';').each do |item|
      pair = item.split(':')
      hash[pair[0]] = pair[1].to_f
    end

    return hash
  end
end
