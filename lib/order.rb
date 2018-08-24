class Order

  attr_reader :id, :customer, :products
  attr_accessor :fulfillment_status

  def self.all


    CSV.open("data/orders.csv", "r").map do |row|

      customer = Customer.find(row[2])

      # Parse out products from string format
      products = {}
      row[1].split(';').each do |product_string|
        product = product_string.split(':')
        products[product[0]] = product[1].to_f
      end

      Order.new(row[0].to_i, products, customer, row[3].to_sym)

    end

  end

  def self.find(id)

    orders = self.all
    return orders.find{ |order| order.id == id }

  end

  def initialize(id, products, customer, fulfillment_status=:pending)

    @id = id
    @customer = customer
    @products = products


    unless [:pending, :paid, :processing, :shipped, :complete ].include?(fulfillment_status)
      raise ArgumentError, "Invalid fulfillment status #{fulfillment_status}. Please try again."
    end

    @fulfillment_status = fulfillment_status

  end

  def total
    return ( @products.sum{ |product, price| price } * 1.075 ).round(2)
  end

  def add_product(product_name, price)

    if @products.include?(product_name)
      raise ArgumentError, "Product #{product_name} is already included in products list. Please try again."
    end

    @products[product_name] = price

  end

end
