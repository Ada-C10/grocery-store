class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)

    valid_statuses = %i[pending paid processing shipped complete]

    @id = id
    @products = products
    @customer = customer

    raise ArgumentError unless valid_statuses.include?(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end

  def total
    subtotal = @products.values.sum
    total = 1.075 * subtotal
    return total.round(2)
  end

  def add_product(product, cost)
    raise ArgumentError if @products.keys.include?(product)
      @products[product] = cost
  end

end
