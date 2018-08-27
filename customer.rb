require 'csv'


class Customer

# helper mothods: automatically add reader and writer methods for these varibales. attr_accessor allows for write and read access
attr_reader :id
attr_accessor :email, :address


# constructor: this will automatically called wen Customer.new is invoked
  def initialize(id, email, address)
  # instance varibales/attribute - not visible outside this class
    @id = id
    @email = email
    @address = address
  end
  # class methods
  def self.all
    # inport csv file, into customers_arry. map over that array to create a new instance of Customer. Return the instances of all customers. turn the address into one element
    customers_data = CSV.read("data/customers.csv")
      customer_all = customers_data.map do |customer|
        address = "#{customer[2]} #{customer[3]}, #{customer[4]}"
        Customer.new(customer[0].to_i, customer[1], address)
      end
    return customer_all
  end

  def self.find(id)
    customers = Customer.all
    find_customer = customers.select do |customer|
      customer.id == id
    end
    return find_customer.first
  end



end
