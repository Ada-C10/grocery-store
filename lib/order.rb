class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status


    unless VALID_STATUSES.include? (fulfillment_status)
      raise ArgumentError
    end
  end

  def total
    all_prices = @products.values
    subtotal = all_prices.sum
    tax = subtotal * 0.075
    total = subtotal + tax
    return total.round(2)
  end

  def add_product(product, price)
    products = @products.keys
    if products.include? (product)
      raise ArgumentError
    else
      @products[product] = price
    end
  end

  def self.all
    orders = []

    CSV.read('data/orders.csv').each do |order|

      id = order[0].to_i

      products_hash = {}
      order_products = order[1].split(';')
      order_products.each do |product|
        separate = product.split(':')
        products_hash[separate[0]] = separate[1].to_f
      end
      products = products_hash

      customer = Customer.find(order[2].to_i)

      fulfillment_status = order[3].to_sym

      orders << Order.new(id, products, customer, fulfillment_status)
    end

    return orders
  end

  def self.find(id)
    orders = Order.all
    orders.find do |order|
      order.id == id
    end
  end

end
