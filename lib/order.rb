TAX = 0.075

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

  def total
    subtotal = @products.sum do |key, value|
      value
    end

    total = subtotal + (subtotal * TAX)

    return total.round(2)


  end

end


# A total method which will calculate the total cost of the order by:
# Summing up the products
# Adding a 7.5% tax
# Rounding the result to two decimal places
# An add_product method which will take in two parameters, product name and price, and add the data to the product collection
# If a product with the same name has already been added to the order, an ArgumentError should be raised
