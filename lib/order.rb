require 'pry'
# create Order class
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    # make an array of valid symbols with %i
    valid_status = %i[pending paid processing shipped complete]
    unless valid_status.include?(fulfillment_status)
      raise ArgumentError, 'Invalid order status'
    end
  end

  # self method to gather all order instances
  def self.all
    all_orders = []
    # returns a collection of Customer instances, representing all Customers in csv
    orders = CSV.open('data/orders.csv', 'r').map { |line| line }
    orders.each do |ord|
      #binding.pry
      id = ord[0].to_i
      # first split string into array by ;
      # ord => "Sun dried tomatoes:90.16;Mastic:52.69;Nori:63.09;Cabbage:5.35"
      ord_arr = ord[1].split(';')
      # map array to new hash where k,v are split by :
      # ord_arr => ["Sun dried tomatoes:90.16", "Mastic:52.69", "Nori:63.09", "Cabbage:5.35"]
      products = Hash[ord_arr.map { |el| el.split(':', 2) }]
      # products => {"Sun dried tomatoes"=>"90.16", "Mastic"=>"52.69", "Nori"=>"63.09", "Cabbage"=>"5.35"}
      products.each { |k, v| products[k] = v.to_f }
      # TODO: try regex approach ??
      customer = Customer.find(ord[2].to_i)
      fulfillment_status = ord[3].to_sym
      # add each current instance to the all_customers array
      all_orders << self.new(id, products, customer, fulfillment_status)
      #binding.pry
      end

    # binding.pry
    return all_orders
  end

  # method to find order instance based on id
  def self.find(id)
    # returns an instance of Customer where the value matches the id parameter
    # provided !!invokes Customer.all and search through results for matching id
    found = Order.all.find { |ord| ord.id == id }

    return found
  end

  def self.find_by_customer(customer_id)
    found = Order.all.find_all do |order|
      # ap order.customer.id
      order.customer.id == customer_id
    end

    if found.empty?
      raise ArgumentError.new ('Customer ID does not exist')
    else
      return found
    end
    # ap found
    # return found
  end

  # calc total cost of order
  def total
    # input: products info
    # if no products return 0
    return 0 if products.empty?
    # sum of all product costs
    # add all of the product values .reduce to get sum
    # must call instance variable!
    s_total = @products.values.reduce(:+)
    # binding.pry# add 7.5% tax
    tax = (0.075 * s_total)
    # round result to 2 decimals
    total_amt = (tax + s_total).round(2)

    return total_amt
  end

  # add another product
  def add_product(prod_name, prod_price)
    # inputs: product name
    #         product price
    # verify that product name is a string
    # verify that product price is a float
    # verify that the product name is unique does key already exist
    raise ArgumentError, 'Item already exists' if products.key? prod_name
    products[prod_name] = prod_price
    # products << prod_hash
    add_msg = "#{prod_name} was added to the order with a price of #{prod_price}."

    return add_msg
  end

  # remove a product
  def remove_product(prod_rm)
    # verify that prod name is in array of products
    if products.key? prod_rm
      # if matches remove that item's hash from the array
      # search by key (prod_name)
      products.delete_if { |k, _| k == prod_rm }
      rm_msg = "Removing #{prod_rm} from order."
    else
      raise ArgumentError, 'Product not found!'
    end
    return rm_msg
  end
end


