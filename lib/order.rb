require_relative 'customer.rb'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@order_list

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError unless valid_statuses.include? fulfillment_status
    @fulfillment_status = fulfillment_status
  end

  def self.extract_products(csv_line)
    product_hash = {}
    products = csv_line.clone

    [0, -1, -1].each do |i|
      products.delete_at(i)
    end

    products.each do |combined_product_price|
      individual_product_prices = combined_product_price.split(';')
      individual_product_prices.each do |product_price|
        separate = product_price.split(':')
        product_hash[separate[0]] = separate[1].to_f
      end
    end

    return product_hash
  end


  def self.fill_order_list
    @@order_list = CSV.open("data/orders.csv", "r").map do |line|
      self.new(line[0].to_i, self.extract_products(line), Customer.find(line[-2].to_i), line[-1].to_sym)
      #need to parse products into hash
    end
  end

  def self.all
    self.fill_order_list
    return @@order_list
  end

  def self.find(id)
    self.all.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end


  def total
    total = 0.00
    @products.each do |item, cost|
      total += cost
    end

    total *= 1.075
    return total.round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError if @products.keys.include? product_name
    @products[product_name] = price
  end

  def remove_product(product_name)
    @products.delete(product_name) { raise ArgumentError }
  end

end

Order.fill_order_list
