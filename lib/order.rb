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
      id = line[0]
      products = line[1].split(";")
      customer_id = line[2]
      fulfillment_status = line[3]

      products = products.map do |product|
        key_value = product.split(":")
      end

      products.to_h
      binding.pry
      # Order.new( @id = line[0], @products = {products:line[1], price: line[1] }
      #   @address = {
      #     street: line[2],
      #     city: line[3],
      #     state: line[4],
      #     zip: line[5]
      #     })
      end
        # return @@customer
    end

end
