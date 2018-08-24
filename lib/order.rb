class Order
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id
    @products = {}
    @customer = customer
    @fulfillment_status ||= :pending
  end

  attr_reader :id,
  attr_accessor :products, :products, :customer, :fulfillment_status
end
