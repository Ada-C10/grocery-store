require "pry"
require "csv"
require_relative "customer"

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  # Integer, Hash, Class::Customer, Symbol
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products # { "banana" => 1.99, "cracker" => 3.00 }
    @customer = customer
    @fulfillment_status = fulfillment_status

    @@valid_statuses = %i[pending paid processing shipped complete]
    unless @@valid_statuses.include?(@fulfillment_status)
      raise ArgumentError, ":fulfillment_status is invalid. Try: " \
                           "[:pending (default), :paid, :processing, " \
                           ":shipped, :complete]"
    end
  end

  def total
  # calculate total cost of order from @products hash
    subtotal = @products.values.sum
    return total = (subtotal*1.075).round(2)
  end

  # string, float/integer
  def add_product(product_name, price)
    if @products.keys.include?(product_name)
      raise ArgumentError, "Your order already has a product with this name."
    end
    return @products[product_name] = price
  end

  def remove_product(product_name)
    unless @products.keys.include?(product_name)
      raise ArgumentError, "There isn't a product with that name in your order."
    end
    return @products.delete(product_name)
  end

  def self.all
  # return collection of Orders from CSV
    all_orders = []

    unless File.exist?("../data/orders_with_headers.csv")
      headers = [:order_id, :products, :customer_id, :status]
      new_csv = CSV.read("../data/orders.csv").unshift(headers)
      CSV.open("../data/orders_with_headers.csv", "w", headers: headers) { |f| new_csv.each { |a| f << a } }
    end

    imported_csv = CSV.read("../data/orders_with_headers.csv", headers: true, :header_converters => :symbol, :converters => :integer).map{ |r| r.to_h}
    # [{:order_id=>1, :products=>"Lobster:17.18;Annatto seed:58.38;
    # Camomile:83.21", :customer_id=>25, :status=>"complete"}, ... etc. ]

    imported_csv.map do |h| # make this a sep method
      str = h[:products].gsub(/:/, ";")
      arr = str.split(";")
      # convert every other array element (price) to float
      arr = arr.map.with_index { |v,i| i%2 == 1 ? v.to_f : v }
      hsh = Hash[*arr]
      h[:products] = hsh
      h[:status] = h[:status].to_sym
    end
    # [{:order_id=>1, :products=>{"Lobster"=>17.18, "Annatto seed"=>58.38,
    # "Camomile"=>83.21}, :customer_id=>25, :status=>"complete"}, ... etc. ]

    imported_csv.each do |h|
      id = h[:order_id]
      products = h[:products]
      customer = Customer.find(h[:customer_id])
      fulfillment_status = h[:status]
      all_orders << Order.new(id, products, customer, fulfillment_status)
    end

    return all_orders
    #[#<Order:0x00007fbfc995f958 @id=1, @products={"Lobster"=>17.18,
    # "Annatto seed"=>58.38, "Camomile"=>83.21},
    # @customer=#<Customer:0x00007fbfc99603d0 @id=25, @email="summer@casper.io",
    # @address={:address_1=>"66255 D'Amore Parkway", :city=>"New Garettport",
    # :state=>"MO", :zip_code=>57138}>, @fulfillment_status=:complete>, ... ]
  end

#   def self.find(id)
# # returns instance of Order where id = id
#     all_orders = self.all
#     return all_orders.find{|obj| obj.id == id}
#   end
 end

# To Do:
# make better comments to guide reader through doc
# csv parsing stuff in separate method
# consistent indentation for comments in customer.rb
# what's wrong with rake?
