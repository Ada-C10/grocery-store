#require_relative '..lib/customer'
class Order
  @@orders = []

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id
    # if @id.class != integer
    #   puts "not a num"
    # end

    @products = products
    # if @product_cost.class != hash
    #   puts "not a hash"
    # end

    @customer = customer

    @fulfillment_status = fulfillment_status

    raise ArgumentError unless
    @fulfillment_status == :pending || @fulfillment_status == :paid || @fulfillment_status == :processing || @fulfillment_status == :shipped || @fulfillment_status == :complete
  end

  def add_product(name, price)
    if @products.include?(name)
      raise ArgumentError
    end
    return @products[name] = price
  end

  def total
    expected_total = 0.00
    tax = 7.5 / 100
    @products.each_value do |value|
      expected_total += value
    end
    expected_total = (expected_total * tax) + expected_total
    return expected_total.round(2)
  end

  def self.all
    @@orders = CSV.open('data/orders.csv', 'r').map do |line|
      id = line[0].to_i
      products = Hash[*line[1].split(/:|;/)]
      products.each do |key, value|
        products[key] = value.to_f
      end
      customer = Customer.find(line[2].to_i)
      fulfillment_status = :"#{line[3]}"

      Order.new(id, products, customer, fulfillment_status)
    end
    return @@orders
  end

  def self.find(id)
    x = ""
    Order.all.each do |ord|
      if ord.id == id
        x = ord
        break
      else
        x = nil
      end
    end
    return x
  end

end
