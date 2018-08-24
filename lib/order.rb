class Order
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products #hash {item: cost}
    @customer = customer
    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError, "Invalid fulfillment status" unless valid_statuses.include? fulfillment_status
    @fulfillment_status = fulfillment_status
  end

  attr_reader :id
  attr_accessor :products, :products, :customer, :fulfillment_status

  def total
    order_total = @products.values.reduce(0.0){ |total, price| total + price}
    order_total_with_tax = order_total * 1.075
    return order_total_with_tax.round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError, "Repeated Item" if @products.keys.include? product_name
    @products[product_name] = price
  end

end

# products = { "banana" => 1.99, "cracker" => 3.00 }
# friday = Order.new(1337, products, 'customer')
# p order.total(products)
# order.add_product('banana', 4.25)
# p order.products
# p order.total(products)
