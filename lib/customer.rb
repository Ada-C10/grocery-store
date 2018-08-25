require 'csv'
require 'pry'
# @@customers_array = CSV.read("data/customers.csv")

class Customer
  attr_reader :id
  attr_accessor :email, :address

  @@customers = []

  def initialize(id, email, address)
    @id = id.to_i
    @email = email
    @address = address
  end

  def add_to_customers
    @@customers << self
  end

  def self.all
    @@customers
  end

  def self.find(id)
    @@customers.each do |customer|
      if customer.id == id
        return customer 
        # return customer.id # returned all customers not just one
      end
    end
    # if id == self.name
    #   return self
    # end
  end

end

# csv_array = []
CSV.open("data/customers.csv",'r').each do |line|
  address = {street: line[2], city: line[3], state: line[4], zip: line[5]}
  cust = Customer.new(line[0], line[1], address)
  cust.add_to_customers
end
