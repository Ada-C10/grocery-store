class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@valid_statuses = %i[pending paid processing shipped complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid(fulfillment_status)
  end


  def valid(fulfillment_status)

    if @@valid_statuses.include?(fulfillment_status)

    else
      raise ArgumentError
    end
  end


  def total
    tax = products.values.sum * 0.075
    (tax + products.values.sum).round(2)
  end


  # def add_product(product, price)
  #   price = Integer
  #   @product << {products["product"] => products[price]}
  #
  # end
end
