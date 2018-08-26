require 'csv'


class Customer

# helper mothods: automatically add reader and writer methods for these varibales. attr_accessor allows for write and read access
attr_reader :id
attr_accessor :email, :address
@@all
@@find

# constructor: this will automatically called wen Customer.new is invoked
  def initialize(id, email, address)
  # instance varibales/attribute - not visible outside this class
    @id = id
    @email = email
    @address = address
  end
  # class methods
  def self.all
    # inport csv file, into customers_arry. map over that array to create a new instance of Customer. Return the instances of all customers
    customers_array = CSV.read("data/customers.csv")
    all_customers = customers_array.map do |customer|
      Customer.new(customer[0].to_i, customer[1], customer[2])
    end
    return all_customers

  end

  def self.find(id)
    return @@find
  end



end
