require 'csv'
require 'awesome_print'
filename = "data/orders.csv"
class Order
  #
  filename = "data/orders.csv"
  def initialize(id, products, customer, fulfillment_status = :pending)
    #CSV.read(filename,'r').map do |line|
      #if line[0] == order_id
        @id = id
        if products.keys == {}
          @products = 0
        end
        @products = products
        @customer = customer
        if fulfillment_status != :pending && fulfillment_status != :paid && fulfillment_status != :processing && fulfillment_status != :shipped && fulfillment_status != :complete
          raise ArgumentError, "No status provided"
        else
          @fulfillment_status = fulfillment_status
        end

        # array = products.split(';')
        # hash = {}
        #   array.each do |item|
        #     hash ["#{item.split(':').first}"] = (item.split(':').last).to_f
        #   end
        # @products = hash
      #end
    #end
  end
  attr_reader :id, :products, :customer, :fulfillment_status

  def total
    array = @products.values
    if array != []
      tally = array.reduce(:+)
      tally += (0.075 * tally)
      return tally.round(2)
    else
      return 0
    end
  end

  def add_product(product_name, price)
    if (@products).include?(product_name)

      raise ArgumentError, "This item has already been added"
    end
    @products["#{product_name}"] = price
  end
end
