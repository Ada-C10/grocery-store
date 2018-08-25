require 'pry'
# Wave 1 order class creations

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    # refractor later: use turnery here to raise the argument
    # raise ArgumentError if [:pending, :paid, :processing, :shipped,  :complete].fulfillment_status?

    @id = id
    @products = products
    @customer = customer
    if [:pending, :paid, :processing, :shipped, :complete].include?fulfillment_status
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end
  end

# add new product, raise an argument error if the product already exists
  def add_product(product, price)
    # check if the product exists
    @products.each do |item, price|
      if item == product
        raise ArgumentError
        # Adds the data to the product collection
      end
    end
    @products[product] = price

    return @products
  end

# Tally the total and return total cost with tax calculated
def total
  total = 0.00
  if @products != nil
    @products.each do |product, price|
      # sums products
      total += price
    end
    # Adds a 7.5% tax
    total += (total * 0.075)
  end

  return total.round(2)
end
end
