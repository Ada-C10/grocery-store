class Order

  attr_reader :id
  attr_accessor :products

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_status_list = [:pending, :paid, :processing, :shipped, :complete]
    if !valid_status_list.include? @fulfillment_status
      raise ArgumentError, "Invalid fulfillment status."
    end
  end
end

test = Order.new(2452, {"apples" => 1}, "Anna", :blah)
