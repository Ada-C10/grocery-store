require 'csv'
require 'awesome_print'
require 'pry'
# Customer class
class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all_customers = []
    # returns a collection of Customer instances, representing all Customers in csv
    customers = CSV.open('data/customers.csv', 'r').map do |line|
      line
    end

    customers.each do |cust|
      #binding.pry
      id = cust[0].to_i
      email = cust[1]
      address = { street: cust[2], city: cust[3], state: cust[4], zip: cust[5] }
      # add each current instance to the all_customers array
      all_customers << self.new(id, email, address)
      #binding.pry
    end

    # binding.pry
    return all_customers
    # TODO: Is it possible to DRY this up where CSV gets imported and each line
    #       is read into class instance of all customers array?????

  end

  def self.find(id)
    # returns an instance of Customer where the value matches the id parameter
    # provided !!invokes Customer.all and search through results for matching id
    found = Customer.all.find { |cust| cust.id == id }

    return found
  end

  # def load_data(filename)
  #   olympic_data = CSV.open(filename, 'r', headers: true).map do |item|
  #     item.to_h
  #   end
    # p olympic_data.class
    # return olympic_data

  # end
end
