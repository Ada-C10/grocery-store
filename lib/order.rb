require "pry"

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@orders = []
  @@valid_statuses = %i[pending paid processing shipped complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid(fulfillment_status)
  end


  def valid(fulfillment_status)

    if @@valid_statuses.include?(fulfillment_status)
    else
      raise ArgumentError
    end
  end


  def total
    tax = products.values.sum * 0.075
    (tax + products.values.sum).round(2)
  end


  def add_product(product, price)

    if @products.include?(product)
      raise ArgumentError
    else
      @products.store(product, price)
    end
  end

  def self.all
    @@orders = CSV.open('data/orders.csv', 'r').map do |line|
      id = line[0].to_i
      products = line[1].split(";")
      customer = line[2].to_i
      fulfillment_status = line[3].to_sym

      products = products.map do |product|
        key_value = product.split(":")
        key_value[1] = key_value[1].to_f
        key_value
      end

      products = products.to_h
      Order.new(
        id,
        products,
        Customer.find(customer),
        fulfillment_status
      )
    end

  end

end
