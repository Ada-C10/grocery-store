
class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError unless valid_statuses.include? fulfillment_status
    @fulfillment_status = fulfillment_status
  end

  def total
    total = 0.00
    @products.each do |item, cost|
      total += cost
    end

    total *= 1.075
    return total.round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError if @products.keys.include? product_name
    @products[product_name] = price
  end

  def remove_product(product_name)
    @products.delete(product_name) { raise ArgumentError }
  end

end
