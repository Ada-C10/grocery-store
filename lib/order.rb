class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  @@valid_statuses = %i[pending paid processing shipped complete] # array of keys

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    check_valid(@fulfillment_status)
  end

  def check_valid(bogus_status)
      if @@valid_statuses.include?(bogus_status)

      else
        raise ArgumentError, "bogus status!"
      end
  end

end
