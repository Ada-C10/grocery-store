require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  @@customers = []
  # Create constructor method for each .new instance of Customer
  def initialize(id, email, address)
    @id = id.to_i
    @email = email
    @address = address
  end

  # Method to add each Customer.new to array of Customer instances
  def add_to_customers
    @@customers << self
  end

  # Customer class method to list all of Customer instances
  def self.all
    @@customers
  end

  # Customer class method to find instance of Customer by id
  def self.find(id)
    found_customer = nil

    Customer.all.each do |customer|
      if customer.id == id
        found_customer = customer
      end
    end

    return found_customer
  end
end

# Open CSV of Customer data and read each into instance of Customer 
CSV.open("data/customers.csv",'r').each do |line|
  address = {street: line[2], city: line[3], state: line[4], zip: line[5]}
  cust = Customer.new(line[0], line[1], address)
  cust.add_to_customers
end
