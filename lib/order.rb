class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses = %i[pending paid processing shipped complete]
    if !valid_statuses.include?(@fulfillment_status)
      raise ArgumentError, "Invalid fulfillment_status"      
    end
  end
end
