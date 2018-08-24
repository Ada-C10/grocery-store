class Order

  attr_reader :id

  def initialize(id, products, Customer, fulfillment_status: pending)
    @id = id
    @products = products # hash of products and costs
    @fulfillment_status = fulfillment_status

    @fulfillment_options = [:pending, :paid, :processing, :shipped :complete]

    unless fulfillment_options.include? fulfillment_status
      raise ArgumentError, 'Fulfillment status must be :pending, :paid, :processing, :shipped, or :complete. '
    end # end of Argument Error unless
  end # end of def initialize


  def total(product_sum)
    @product_sum = products[:cost].sum * .075
  end # end of def total


  def add_product(product_name, product_price)
    if @products.include? product.name
      raise ArgumentError, "Product is already on product list."
    end

    @products << {product_name: product_price}
  end # end of def add_product

end # end of class Order
