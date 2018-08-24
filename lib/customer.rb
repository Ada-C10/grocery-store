require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # returns an array of Customer objects
  def self.all
    all_customers = CSV.open("data/customers.csv").map do |row|
      id = row[0].to_i
      email = row[1]
      address = {street: row[2], city: row[3],
        state: row[4], zip: row[5]}
      Customer.new(id, email, address)
    end
    return all_customers
  end

  # returns a Customer object matching the designated id
  def self.find(id)
    all_customers = Customer.all
    return all_customers[id-1]
  end
end
