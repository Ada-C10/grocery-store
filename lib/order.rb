# Jacquelyn Cheng - Nodes

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    if ![:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
      raise ArgumentError, "Invalid fulfillment status"
    end
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
        products[product_and_price[0]] = product_and_price[1].to_f
      end
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym
      Order.new(id, products, customer, fulfillment_status)
    end
    return all_orders
  end

  # returns an Order instance matching the designated id
  def self.find(order_id)
    Order.all.each do |order|
      if order.id == order_id
        return order
      end
    end
    return nil
  end

  # returns a **list** of `Order` instances where the value of the customer's
  # ID matches the passed parameter
  def self.find_by_customer(cust_id)
    customer_ids = Customer.all.map do |customer|
      customer.id
    end
    if !customer_ids.include? cust_id
      raise ArgumentError, "Customer #{cust_id} not found"
    end
    customer_orders = []
    Order.all.each do |order|
      if order.customer.id == cust_id
        customer_orders << order
      end
    end
    return customer_orders
  end

  # calculates total cost of order by summing products, add 7.5% tax, 2 decimals
  def total
    return (@products.values.sum * 1.075).round(2)
  end

  # adds product to hash or raises argument error if product already in hash
  def add_product(product_name, product_price)
    if !@products[product_name]
      @products[product_name] = product_price
    else
      raise ArgumentError, "Product already on order"
    end
  end

  # removes the product and returns it, or returns nil if no product found
  def remove_product(product_name)
    if @products[product_name]
      return @products.delete(product_name)
    else
      return nil
    end
  end
end
