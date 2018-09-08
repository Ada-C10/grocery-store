#Products structure { "banana" => 1.99, "cracker" => 3.00 }
#Fulfuillment_status: :pending, :paid, :processing, :shipped, or :complete
require_relative 'customer.rb'

class Order
attr_accessor :products, :customer, :fulfillment_status
attr_reader :id
  def initialize(id, products, customer, fulfillment_status= :pending)
    @id = id
    @products = products
    @customer = customer

    #Verifies the fulfillment status is one that matches expected input
    if [:pending, :paid, :processing, :shipped,:complete].include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError,"A valid fulfillment_status was not put into the Order"
    end
  end

  #Adds the total cost of the products and includes tax (7.5%)
  def total
    if @products.length == 0
      return 0
    else
      total = @products.values.reduce(:+)
      total*= 1.075 #Tax
      total = total.round(2)
      return total
    end
  end

  #Add's a product to the product hash in the order if it doesn't already exist
  def add_product(product_name, price)
    if @products.keys.include?(product_name)
      raise ArgumentError,"The product is already in the order"
    else
      @products[product_name] = price
    end
  end

  #Removes a product from the product hash in the order if it already exists
  def remove_product(product_name)
    if @products.keys.include?(product_name)
      @products.reject! { |k| k == product_name }
    else
      raise ArgumentError, "The product does not exist in the order"
    end
  end

  #Method to create the product Hash from CSV input structure
  def self.product_hash(order)
      products = order.split(';')
      products_hash = {}
      products.each do |product|
        products_hash[product.split(':')[0]]= product.split(':')[1].to_f
      end
      return products_hash
  end

  #Creates all the orders from the orders.csv file
  def self.all
    data = CSV.open('data/orders.csv', 'r').map do |line|
      line.to_a
    end
    all_orders = []
    data.each do |order|
      all_orders << Order.new(order[0].to_i, product_hash(order[1]), Customer.find(order[2].to_i), order[3].to_sym)
    end
    return all_orders
  end

  #Finds an order based on the order id
  def self.find(id)
    all_orders = Order.all
    order = all_orders.find {|order| order.id == id}
    return order
  end

  #Finds all orders associated with a customer id and returns it in an array
  def self.find_by_customer(customer_id)
    all_orders = Order.all
    orders_by_customer = all_orders.select { |order| order.customer.id == customer_id}
    if orders_by_customer.empty?
      return nil
    else
      return orders_by_customer
    end
  end
end
