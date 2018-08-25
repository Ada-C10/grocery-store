require 'csv'
require 'awesome_print'

class Order

attr_reader :id

def initialize(id, products, customer, fulfillment_status = :pending)
  @id = id
  @products = products
  @customer = customer

  if fulfillment_status == :pending || fulfillment_status == :paid || fulfillment_status == :processing || fulfillment_status == :shipped || fulfillment_status == :complete
    @fulfillment_status = fulfillment_status
  else
    raise ArgumentError, 'An invalid fulfillment status value has been entered'
  end
end

def id
  return @id
end

def products
  return @products
end

def customer
  return @customer
end

def fulfillment_status
  return @fulfillment_status
end

def total
  total_wo_tax = 0
  tax_rate = 0.075

  @products.each do |k,v|
    total_wo_tax += v
  end

  tax = tax_rate * total_wo_tax

  total_with_tax = total_wo_tax + tax
  total_with_tax_round = total_with_tax.round(2)

  return total_with_tax_round
end

def add_product(product_name, price)

  if @products[product_name]
      raise ArgumentError, 'This product is already in the database'
  end

  @products[product_name] = price

end

# returns a collection of Order instances, representing all of the Orders described in the CSV file
def self.all
  all_order_instances = []

  CSV.open("data/orders.csv", "r").map do |line|
    product_hash = {}
    id = line[0].to_i
    all_products = line[1]
    all_products_into_array = all_products.split(";")

    index = 0
    while index < all_products_into_array.length
      each_product_own_array = all_products_into_array[index].split(":")
      product_hash[each_product_own_array[0]] = [each_product_own_array[1]]

      index += 1
    end

    customer_id = line[2].to_i
    status = line[3].to_sym

    new_order = Order.new(id, product_hash, customer_id, status)
    all_order_instances << new_order
  end

  return all_order_instances
end

end

# TEST
run_method = Order.all
puts "#{run_method}"

index = 0
while index < run_method.length
  x = run_method[index]
  puts "Order num: #{x.id} | products: #{x.products} | customer: #{x.customer} | status: #{x.fulfillment_status}"
  index += 1
end
