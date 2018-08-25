class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = {}
    @customer = customer
    @fulfillment_status = fulfillment_status


    unless VALID_STATUSES.include? (fulfillment_status)
      raise ArgumentError
    end
  end
  
end
