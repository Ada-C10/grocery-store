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

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError, "Product already exists in the system"
    else
      @products[product_name] = price
    end

  end

  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError, "Product does not exist in our system"
    end
  end
end


# An add_product method which will take in two parameters, product name and price, and add the data to the product collection
# If a product with the same name has already been added to the order, an ArgumentError should be raised
