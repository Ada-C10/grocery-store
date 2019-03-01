#Order class
require 'pry'
class Order


  attr_reader :id

  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status


    if ![:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status then
      raise ArgumentError.new("Status must be pending, paid, processing, shipped or complete")
    end
  end#Order class
require 'pry'
class Order


  attr_reader :id

  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    @order = []


    if ![:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status then
      raise ArgumentError.new("Status must be pending, paid, processing, shipped or complete")
    end
  end

  def add_product(product_name,price)
    @products.each do |name, price|
      if name == product_name
        raise ArgumentError
      end
    end
    @products[product_name] = price
  end


  def total
    product_sum = @products.sum {|k,v| v}
    product_tax = product_sum * 0.075
    product_total = product_sum + product_tax

    return product_total.round(2)
  end

  def self.all
  CSV.open('./data/orders.csv').map do |order|


    @order =
    :id = order[0].to_i,
    :products = order[1... -3],
    customer = order[-2],
    status = order[-1]
    Order.new(id,products, customer, status = " ")
  end
  binding.pry
  return @order

  end
end


  def add_product(product_name,price)
    @products.each do |name, price|
      if name == product_name
        raise ArgumentError
      end
    end
    @products[product_name] = price
  end


  def total
    product_sum = @products.sum {|k,v| v}
    product_tax = product_sum * 0.075
    product_total = product_sum + product_tax

    return product_total.round(2)
  end

  def self.all
  CSV.open('./data/orders.csv').map do |order|
    id = order[0].to_i
    products = order[1...-3]
    customer = order[-2]
    status = order[-1]

    Order.new(id,products, customer, status)
  end
  end
end
