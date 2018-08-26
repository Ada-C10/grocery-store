require_relative 'csv'

def self.load_data(filename) #take file name and returns data from file in array of hashes
  data = CSV.open(filename,'r', headers:false).map do |line|
  line.to_a
  end
  return data
end

def self.format_data(data)
    data.each do |individual|
      id = individual[0].to_i
      products = individual[1]
      customer =
      customer_status

    @@orders << self.new(id, products, customer, fulfillment_status = :pending)

    end
  return @@orders
end

class Order
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products #hash {item: cost}
    @customer = customer
    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError, "Invalid fulfillment status" unless valid_statuses.include? fulfillment_status
    @fulfillment_status = fulfillment_status
  end

  attr_reader :id
  attr_accessor :products, :products, :customer, :fulfillment_status

  def total
    order_total = @products.values.reduce(0.0){ |total, price| total + price}
    order_total_with_tax = order_total * 1.075
    return order_total_with_tax.round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError, "Repeated Item" if @products.keys.include? product_name
    @products[product_name] = price
  end

  def self.all
    return @@orders#collection of Customer instances - all of the ifno from csv file
  end

  def self.find(id)
    @@orders.each do |order|
      if id.to_i == order.id.to_i
        return order
      end
    end
    return nil
  end
end


end

# products = { "banana" => 1.99, "cracker" => 3.00 }
# friday = Order.new(1337, products, 'customer')
# p order.total(products)
# order.add_product('banana', 4.25)
# p order.products
# p order.total(products)
