class Order

  attr_reader :id

  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products # hash of products and costs

    puts fulfillment_status
    @fulfillment_status = fulfillment_status

    @fulfillment_options = [:pending, :paid, :processing, :shipped, :complete]

    unless @fulfillment_options.include? @fulfillment_status
      raise ArgumentError, 'Fulfillment status must be :pending, :paid, :processing, :shipped, or :complete. '
    end # end of Argument Error unless
  end # end of def initialize


  def total(products)
    # @product_sum = products[:cost].sum * 1.075
    if @products.empty?
      @product_sum = 0
    else
      @product_sum = @products.values.sum
    end

    return @product_sum
  end # end of def total


  def add_product(product_name, product_price)
    if @products.include? product_name
      raise ArgumentError, "Product is already on product list."
    else
      @products << {product_name: product_price}
    end


  end # end of def add_product

end # end of class Order # why unexpected??
