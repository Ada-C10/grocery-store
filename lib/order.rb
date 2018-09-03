require 'csv'
require 'awesome_print'
require_relative 'customer'
require 'pry'

class Order
  # should products be only read only?
  # is product list their order or what they are choosing from?
  attr_reader :id, :products, :customer, :fulfillment_status
  #accept products as a hash? or do @products = {}
  #write fulfillement status like below, or put keyword argument into Class arguements
  #fulfillment_status: pending
  def initialize(id, products, customer, fulfillment_status= :pending)
    @id = id
    @products = products
    @customer = customer
    status_options = [:pending, :paid, :processing, :shipped, :complete]
    if status_options.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError.new("This is not a valid status.")
    end

  end
  #wants <#93r9usdlkfja4nf I believe
  # params integer
  # returns integer
  # should return customer object
  def customer_info(customer)
    return customer
  end

  def total
    #sum products
    #TODO: could make this cleaner(more concise) probably.
    if @products.empty?
      return 0
    else
      sum = @products.values.reduce(:+)
    end
    #add sales tax
    sales_tax_total = (sum * 1.075).round(2)
    return sales_tax_total
  end

  def add_product(product_name, price)
    @products.each do |k, v|
      if product_name == k
        raise ArgumentError.new("This product already exists")
      end
    end
    @products[product_name] = price
  end

  def self.all
    total_orders = CSV.open('data/orders.csv', 'r').map do |line|
      products = line[1].split(/[;:]/)
      # changing array into hash
      # making values all floats
      products_hash = Hash[*products].map { |k,v| [k, v.to_f] }.to_h
      customer_id = line[2].to_i
      # binding.pry
      Customer.all
      # binding.pry
      Order.new(line[0].to_i, products_hash, Customer.find(customer_id),
      line[3].to_sym)
    end

    return total_orders
  end

  def self.find(id)
    self.all.find { |x| x.id == id }
  end

end
