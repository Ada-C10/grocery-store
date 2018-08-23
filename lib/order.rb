class Order

  attr_reader :id, :customer, :products
  attr_accessor :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending)

    @id = id
    @customer = customer
    @products = products


    unless [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)
      raise ArgumentError, "Invalid fulfillment status #{fulfillment_status}. Please try again."
    end

    @fulfillment_status = fulfillment_status

  end

  def total
    return ( @products.sum{ |product, price| price } * 1.075 ).round(2)
  end

  def add_product(product_name, price)

    if @products.include?(product_name)
      raise ArgumentError, "Product #{product_name} is already included in products list. Please try again."
    end

    @products[product_name] = price

  end

end
