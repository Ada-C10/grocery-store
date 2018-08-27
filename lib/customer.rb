require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #<-- int
    @email = email #<-- string
    @address = address  #<-- hash
  end

  # instantiate each row in csv as new Customer instances
  # returns an array with each Customer object
  def self.all
    all_customers = CSV.open("data/customers.csv", 'r').map do |line|
      id = line[0].to_i
      email = line[1]

      address = {
        street: line[2],
        city: line[3],
        state: line[4],
        zip: line[5]
      }

      new_cust = self.new(id, email, address)
    end

    return all_customers
  end

  # find and return instance of Customer based on id
  # if id does not exist, return nil
  def self.find(id)
    customers = self.all
    return customers.find { |customer| customer.id == id }
  end
end
