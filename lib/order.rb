class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending
  status = [:pending, :paid, :processing, :shipped, :complete]
    if status.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "Not a valid status"
    end
    @id = id
    @products = products
    @customer = customer
  end

  def total
    total = @products.sum {|product,price| price}
    total *= 1.075
    total = total.round(2)
    return total
  end

  def add_product(product, price)
    if @products.include?(product)
      raise ArgumentError "That product already exists"
    else
      @products[product] = price
    end
  end
end
