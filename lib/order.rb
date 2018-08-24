class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses = %i[pending paid processing shipped complete]
    raise ArgumentError, "Invalid fulfillment_status" unless valid_statuses.include?(@fulfillment_status)
  end

  def total
    product_sum = products.values.sum
    sum_plus_tax = product_sum * 1.075
    return sum_plus_tax.round(2)
  end

  def add_product
  end
end
