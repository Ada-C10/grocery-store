require 'csv'
require 'awesome_print'
require 'pry'
# Customer class
class Customer
  attr_reader :id
  attr_accessor :email, :address

  @all_customers = []
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    # returns a collection of Customer instances, representing all Customers in csv
    all_customers = CSV.open('data/customers.csv', 'r').map do |line|
      line
    end

    all_customers.each do |cust|
      #binding.pry
      id = cust[0].to_i
      email = cust[1]
      address = {street: cust[2], city: cust[3], state: cust[4], zip: cust[5]}
      customer = Customer.new(id, email, address)
      @all_customers << customer
    end
    #binding.pry
    return @all_customers
    # TODO: is it possible to DRY this up where CSV gets imported and each line is read into
    #      class instance of all customers array?????
  end

  def self.find(id)
    # returns an instance of Customer where the value matches the id parameter
    # provided !!invokes Customer.all and search through results for matching id
  end

  def load_data(filename)
    olympic_data = CSV.open(filename, 'r', headers: true).map do |item|
      item.to_h
    end
    # p olympic_data.class
    return olympic_data

  end
end
