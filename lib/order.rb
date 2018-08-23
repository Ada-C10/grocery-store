class Order
  attr_reader :id, :customer
  attr_accessor :product_data, :fulfillment_status

  def initialize(id, product_data, customer, fulfillment_status)
    @id = id
    @product_data = product_data
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    # sum up products
    # add 7.5% tax
    # round to two decimal places
  end

  def add_product(product_name, price)
    # add data to product collection
    # raise error if product with same name is already on order
  end

end
