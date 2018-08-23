require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
      if fulfillment_status != :pending &&
        fulfillment_status != :paid &&
        fulfillment_status != :processing &&
        fulfillment_status != :shipped &&
        fulfillment_status != :complete
        raise ArgumentError
      end
  end

  def total()
    total_cost = 0
    products.each do |product_name, cost|
      total_cost += cost
    end

    total_cost_plus_tax = total_cost + (total_cost * 0.075)
    return total_cost_plus_tax.round(2)
  end

  # def add_product(new_product, price_of_new_product)
  #   if products.keys.include?(new_product) == false
  #     products[new_product] = price_of_new_product
  #   elsif products.keys.include?(new_product) == true
  #     raise ArgumentError
  #   end
  # end
end
