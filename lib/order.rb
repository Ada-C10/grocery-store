class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError if ![:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  # returns an array of all orders
  def self.all
    all_orders = CSV.open("data/orders.csv").map do |row|
      id = row[0].to_i
      product_list = row[1].split(';')
      products = {}
      product_list.each do |product_data|
        product_and_price = product_data.split(':')
        products[product_and_price[0]] = product_and_price[1]
      end
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym
      Order.new(id, products, customer, fulfillment_status)
    end
    return all_orders
  end

  # returns an Order instance matching the designated id
  def self.find(id)
    all_orders = Order.all
    return all_orders[id-1]
  end

  def total
    return (@products.values.sum * 1.075).round(2)
    # A `total` method which will calculate the total cost of the order by:
    #   - Summing up the products
    #   - Adding a 7.5% tax
    #   - Rounding the result to two decimal places
  end

  def add_product(product_name, product_price)
    if !@products[product_name]
      @products[product_name] = product_price
    else
      raise ArgumentError
    end
    # An `add_product` method which will take in two parameters, product name and price, and add the data to the product collection
    #   - If a product with the same name has already been added to the order, an `ArgumentError` should be raised
  end


end
