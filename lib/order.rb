require 'pry'

class Order
  attr_reader :id, :customer, :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_statuses = %i[pending paid processing shipped complete]
    print "#{valid_statuses}"
    if valid_statuses.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end
    @id = id
    @customer = customer
    @products = products

  end

  def total
    sum_before_tax = self.products.values.sum
    sum_after_tax = sum_before_tax * 1.075
    return sum_after_tax.round(2)
  end

  def add_product(prd_name, prd_price)
    if @products.keys.include? (prd_name)
      raise ArgumentError,"Product namne exists, try other nanmes"
    else
      @products[prd_name] = prd_price
    end
  end

  def remove_product(prd_name)
    if @products.keys.include? (prd_name)
      @products.delete(prd_name)
    else
      raise ArgumentError,"Product namne does not exist"
    end
  end
end
