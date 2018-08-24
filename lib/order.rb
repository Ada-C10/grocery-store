class Order
  attr_reader :id
  def initialize(id, product_cost, customer, status)
    @id = id
    @product_cost = product_cost
    @customer = customer
    @status = status
  end

  def total()

  end
end
