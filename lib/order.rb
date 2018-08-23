class Order


  def initialize(id_number, products, customer, fulfillment_status = :pending)
    @id_number = id_number
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
