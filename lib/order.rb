class Order
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products #hash {item: cost}
    @customer = customer
    raise ArgumentError, "Invalid fulfillment status" while fulfillment_status != nil,:pending, :paid, :processing, :shipped, :complete
    @fulfillment_status = fulfillment_status
  end

  attr_reader :id
  attr_accessor :products, :products, :customer, :fulfillment_status
end
