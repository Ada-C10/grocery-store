class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products= products
    @customer = customer

    unless VALID_STATUSES.include?(fulfillment_status)
      raise ArgumentError
    end

    @fulfillment_status = fulfillment_status

  end

  def total
    total = @products.values.sum
    total = (total * 1.075).round(2) #calculate tax of 7.5%
    return total
  end

  def add_product(product_name, product_price)
    if @products[product_name]
      raise ArgumentError
    end

    @products[product_name] = product_price

  end


end
