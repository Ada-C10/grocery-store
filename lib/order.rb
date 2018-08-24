require_relative 'customer'

class Order
  attr_reader :id

  def initialize(id, product_cost, customer, status=':pending')
    @id = id
    # if @id.class != integer
    #   puts "not a num"
    # end

    @product_cost = product_cost
    # if @product_cost.class != hash
    #   puts "not a hash"
    # end

    @customer = customer

    @status = status
    # if @status.class != string
    #   puts "not a string"
    # end
  end

  def total()

  end
end
