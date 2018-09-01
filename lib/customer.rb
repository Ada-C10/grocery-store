require 'csv'
require 'pry'

# Wave 1 customer creations

class Customer
  attr_reader :id
  attr_accessor :email, :address

  @@customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  #  Wave 2
  # Load data from CSV
  def self.all
    @@customers = CSV.read("data/customers.csv").map do |line|
      id = line[0].to_i
      email = line[1]
      address = {
        street:  line[2],
        city:  line[3],
        state:  line[4],
        zip:  line[5]
      }
      Customer.new(id, email, address)
    end
    return @@customers
  end

# find a customer from the data provided from the csv file
  def self.find(id)
    customers = self.all
    return customers.find {|customer| id == customer.id}
  end
end
