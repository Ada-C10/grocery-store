require 'pry'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  @@valid_statuses = %i[pending paid processing shipped complete] # array of keys
  #order = Order.new(1337, products, customer)
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
  # products = { "banana" => 1.99, "cracker" => 3.00 }
  def total
    prices = @products.values
    total = prices.sum
    total_and_tax = total * 0.075 + total
    total_and_tax = total_and_tax.round(2)
    if total_and_tax == 0.0
      return 0
    else
      return total_and_tax
    end
  end
# order.add_product("salad", 4.25)
  def add_product(key, value)
    if @products.include?(key)
      raise ArgumentError
    end
    @products[key] = value
  end

end
