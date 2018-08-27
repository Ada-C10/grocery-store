class Order
  attr_reader :id

# Order arguments are:
# integer
# hash (a collection of products and their cost)
# instance of Customer object
# symbol -- :pending (default), :paid, :processing, :shipped, or :complete
  def initialize(id, products, customer, fulfillment_status: :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = :fulfillment_status

    @@valid_statuses = [:pending, :paid, :processing, :shipped, :complete]

    unless @@valid_statuses.include?(@fulfillment_status)
      raise ArgumentError, "Fulfillment Status must be one of these, or blank: :pending (default), :paid, :processing, :shipped, :complete)"
    end

  end

end
