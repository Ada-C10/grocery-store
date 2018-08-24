require_relative 'customer'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
        validate_fulfillment_status
  end

  def validate_fulfillment_status
    fulfillment_status_options = [:pending, :paid, :processing, :shipped, :complete]
    if fulfillment_status_options.include?(fulfillment_status) == false
      raise ArgumentError.new("Fulfillment status :pending, :paid, :processing, :shipped, or :complete")
    end
  end

end
