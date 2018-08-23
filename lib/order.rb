class Order

  attr_reader :id
  attr_accessor :products, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    list_of_statuses = [:pending, :paid, :processing, :shipped, :complete]
    if !list_of_statuses.include? fulfillment_status
      raise ArgumentError, "Unknown fulfillment status"
    else
      @fulfillment_status = fulfillment_status
    end
  end

end
