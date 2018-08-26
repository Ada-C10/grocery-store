require_relative 'customer'


class Order

    attr_reader :id
    attr_accessor :email, :products, :customer, :fulfillment_status

    def initialize(id, products , customer, fulfillment_status = :pending)
        @id = id
        @products = products
        @customer = customer
        @fulfillment_status  = fulfillment_status

        if @fulfillment_status != :paid &&\
           @fulfillment_status != :processing &&\
           @fulfillment_status != :shipped &&\
           @fulfillment_status != :pending &&\
           @fulfillment_status != :complete
              raise ArgumentError
        end
    end

    def total
        # summing all values of products
        product_sum = @products.values.sum
        # 7.5% tax
        tax = (7.5/100) * product_sum
        # return total
        return total = (product_sum + tax).round(2)
    end

    def add_product(product, price)
        if @products.keys.include?(product)
            raise ArgumentError
        else
             # products_and_costs.merge!(product => price)
            @products[product] = price
        end
    end

    def remove_product(product_name)
      if !(@products.keys.include?(product_name))
          raise ArgumentError
      else
          @products.delete(product_name)
      end
    end


end

maryam = Customer.new(2, 'maryam@gmail.com', {street: "605 15th Ave", city: "Seattle", zip_code: 98112 })
ordering = Order.new(3, { "banana" => 1.99, "cracker" => 3.00 }, maryam, :shipped)


# puts "adds beans: "
# p ordering.add_product('beans', 2)

# puts "current products: "
# p ordering.products
#
#
# puts "remove beans: "
# p ordering.remove_product('beans')
#
# puts "current products: "
# p ordering.products
