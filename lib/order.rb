require_relative 'Customer.rb'


class Order
  attr_reader :id, :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    if [:pending,:processing,:shipped,:paid,:complete].include? fulfillment_status
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end

  end

  def total
    total = 0
    @products.each do |product,cost|
      total += cost
    end
    return total += (0.075 * total).round(2)
  end



    def add_product(product,cost)
          if @products.key?(product)
            return false
          elsif
            @products[product] = cost
            return true
          elsif
            @products = product
            raise ArgumentError.new("The product is already present")
          end
  end

end
