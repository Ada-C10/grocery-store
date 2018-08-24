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


  # calc total cost of order
  def total
    # input: products info
    # if no products return 0
    if products.empty?
      return 0
    end
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
    if products.keys.include? prod_name
      raise ArgumentError, 'Item already exists'
    end
    products[prod_name] = prod_price
    # products << prod_hash
    add_msg = "#{prod_name} was added with a price of #{prod_price}"

    return add_msg
  end

  # remove a product
  def remove_product(prod_rm)
    # verify that prod name is in array of products
    if prod_rmv = products.find { |prod| prod[prod_rm] == prod_rm }
      # if matches remove that item's hash from the array
      # search by key (prod_name)
      products.delete_if { |prod| prod[prod_rm] == prod_rm }
      rm_msg = "Removing #{prod_rm} from products."
    else
      rm_msg = 'Product not found!'
    end
    return rm_msg
  end


end