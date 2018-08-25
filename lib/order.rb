class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

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
    all_prices = @products.values
    subtotal = all_prices.sum
    tax = subtotal * 0.075
    total = subtotal + tax
    return total.round(2)
  end

  def add_product(product, price)
    products = @products.keys
    if products.include? (product)
      raise ArgumentError
    else
      @products[product] = price
    end
  end

end
