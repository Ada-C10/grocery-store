class Order
  attr_reader :id

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError if ![:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    return (@products.values.sum * 1.075).round(2)
    # A `total` method which will calculate the total cost of the order by:
    #   - Summing up the products
    #   - Adding a 7.5% tax
    #   - Rounding the result to two decimal places
  end

  def add_product(product_name, product_price)
    if !@products[product_name]
      @products[product_name] = product_price
    else
      raise ArgumentError
    end
    # An `add_product` method which will take in two parameters, product name and price, and add the data to the product collection
    #   - If a product with the same name has already been added to the order, an `ArgumentError` should be raised
  end




end
