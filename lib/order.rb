class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    
    valid_statuses = %i[pending paid processing shipped complete]

    @id = id
    @products = {}
    @customer = customer

    raise ArgumentError unless valid_statuses.include?(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end
end
