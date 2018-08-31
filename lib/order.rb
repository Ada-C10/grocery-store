require 'csv'
require 'pry'
require 'awesome_print'
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
      # raises an error if the product is already the list
      if @products.keys.include?(product)
          raise ArgumentError
      else
      # adds the product to product hash if no error was raised
          @products[product] = price
      end
    end

    def remove_product(product_name)
      # raises error if product is not in list
      if !(@products.keys.include?(product_name))
          raise ArgumentError
      else
      # checks product hash for a product with the same name as product_name
          @products.delete(product_name)
      end
    end

    def self.all
      # goes through each line of csv file == order, creates an instance of Order class
      # for each order and returns all products on file
      all = CSV.open('data/orders.csv', 'r').map do |order|
          products = {}
          # collects all the products from each line of csv file and seperates
          # them from the rest of the data
          product_array = order[1].split(',')
          # separates and goes through all the products and assigns them to a :product and :price key in the products hash
          product_array[0].split(";").each do |item|
              products[item.split(':')[0]] = item.split(':')[1].to_f
          end
          # turns customer id into instance of Customer class
          customer = Customer.find(order[2].to_i)
          # creates an instance of Order class using the info from the order details, all matching the data types of Order's instance variables
          Order.new(order[0].to_i, products, customer, order[3].to_sym)

        end
      return all
    end

    def self.find(id)
        find = Order.all.select { |order| order.id == id }

        if find == []
          return nil
        end

        Order.all.each do |order|
          if order.id == id
            return order
          end
        end
    end

## TODO: Optional method:  returns a list of Order instances where the value of the customer's ID matches the passed parameter.
    def self.find_by_customer(customer_id)

    #   client = Order.all.select { |customer| customer == customer_id }
    #   if client == []
    #     return nil
    #   else
    #     return client
    #   end
    end

end

##########
# maryam = Customer.new(2, 'maryam@gmail.com', {street: "605 15th Ave", city: "Seattle", zip_code: 98112 })
# ordering = Order.new(3, { "banana" => 1.99, "cracker" => 3.00 }, maryam, :shipped)

# ap Order.all

# puts "find by customer: "
# ap Order.find_by_customer(3)
# puts "find by customer: "
# ap Order.find_by_customer(50)

# puts "adds beans: "
# p ordering.add_product('beans', 2)

# puts "current products: "
# p ordering.products
#
# puts "remove beans: "
# p ordering.remove_product('beans')
#
# puts "current products: "
# p ordering.products
