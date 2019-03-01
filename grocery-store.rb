#class Cusotmer
require 'csv'
require 'awesome_print'
require 'pry'

class Customer

  #@@id = 123

  attr_reader :id
@@customers = []
  attr_accessor :email, :address

  def initialize(id, email, address = {street: "", city:"", state: "", zip:""})
    @id = id
    @email = email
    @address = address
  end


  def self.all(filename)
    CSV.open('./data/customers.csv').map do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {street: customer[2], city: customer[3], state: customer[4], zip: customer[5]}
      @@customers<<customer.self(id,email, address)
    end
    return @@customers
  end

ap @@customers

end
# TODO: remove the 'x' in front of this block when you start wave 2
describe "Customer Wave 2" do
  describe "Customer.all" do
    it "Returns an array of all customers" do
      customers = Customer.all

      expect(customers.length).must_equal 35
      customers.each do |c|
        expect(c).must_be_kind_of Customer
      end
    end


    xit "Returns accurate information about the first customer" do
      first = Customer.all.first
      expect(first.id).must_equal 1
    end

    xit "Returns accurate information about the last customer" do
      last = Customer.all.last
      expect(last.id).must_equal 35
    end
  end

  describe "Customer.find" do
    xit "Can find the first customer from the CSV" do
      first = Customer.find(1)

      expect(first).must_be_kind_of Customer
      expect(first.id).must_equal 1
    end

    xit "Can find the last customer from the CSV" do
      last = Customer.find(35)

      expect(last).must_be_kind_of Customer
      expect(last.id).must_equal 35
    end

    xit "Returns nil for a customer that doesn't exist" do
      expect(Customer.find(53145)).must_be_nil
    end
  end
end
require 'pry'
class Order


  attr_reader :id

  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status


    if ![:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status then
      raise ArgumentError.new("Status must be pending, paid, processing, shipped or complete")
    end
  end

  def add_product(product_name,price)
    @products.each do |name, price|
      if name == product_name
      raise ArgumentError
    end
  end
    @products[product_name] = price
  end


  def total
    product_sum = @products.sum {|k,v| v}
    product_tax = product_sum * 0.075
    product_total = product_sum + product_tax

    return product_total.round(2)

  end
end
