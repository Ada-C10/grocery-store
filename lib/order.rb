require_relative 'csv'



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

  def self.load_data(filename) #take file name and returns data from file in array of hashes
    data = CSV.open(filename,'r', headers:false).map do |line|
    line.to_a
    end
    return data
  end

  #Lobster:17.18;Annatto seed:58.38;Camomile:83.21

  def parse_product_array(string)#try regex /:|;/
    products_hash = {}
    products_array = string.split(';') #[lobster:17, annato seed:58]
    products_array.each do |product|
      single_item_array = product.split(':')
      products_hash[single_item_array[0]]= single_item_array[1].to_f
    end
    return products_hash #hash {item:price}
  end

  def self.format_data(data)
      data.each do |individual|
        id = individual[0].to_i
        products = parse_product_array(individual[1])
        customer = individual[2]
        fulfillment_status = individual[3]

      @@orders << self.new(id, products, customer, fulfillment_status = :pending)

      end
    return @@orders
  end

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

# parse_product_array('Lobster:17.18;Annatto seed:58.38;Camomile:83.21')
# products = { "banana" => 1.99, "cracker" => 3.00 }
# friday = Order.new(1337, products, 'customer')
# p order.total(products)
# order.add_product('banana', 4.25)
# p order.products
# p order.total(products)
