class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  DEFAULT_CSV_FILE = "data/orders.csv"
  VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products= products
    @customer = customer

    unless VALID_STATUSES.include?(fulfillment_status)
      raise ArgumentError
    end

    @fulfillment_status = fulfillment_status

  end

  def total
    total = @products.values.sum
    total = (total * 1.075).round(2) #calculate tax of 7.5%
    return total
  end

  def add_product(product_name, product_price)
    if @products[product_name]
      raise ArgumentError
    end

    @products[product_name] = product_price

  end

  def self.all(csv_file = DEFAULT_CSV_FILE)
    all_orders = []

    CSV.open(csv_file, "r").each do |order|
      all_orders << self.csv_to_order(order)
    end

    return all_orders #array of order objects
  end

  def self.find(id, csv_file = DEFAULT_CSV_FILE)
    CSV.open(csv_file, "r").each do |order|
      if order[0].to_i == id
        return self.csv_to_order(order) # returns order object
      end
    end
  end

  def self.csv_to_order(csv_row)
    order_id = csv_row[0].to_i
    order_products = self.parse_products(csv_row[1])
    order_customer = Customer.find(csv_row[2].to_i)
    order_status = csv_row[3].to_sym
    return self.new(order_id, order_products, order_customer, order_status)
  end

  def self.parse_products(products)
    parsed_products = {}

    products.split(";").each do |single_product|
      (product_name, product_cost) = single_product.split(":")
      parsed_products[product_name] = product_cost.to_f
    end

    return parsed_products
  end

end
