require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
      if fulfillment_status != :pending &&
        fulfillment_status != :paid &&
        fulfillment_status != :processing &&
        fulfillment_status != :shipped &&
        fulfillment_status != :complete
        raise ArgumentError
      end
  end
end
