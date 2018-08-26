require 'csv'
require 'pry'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize (id, email, address)
    @id = id # gonna be an int
    @email = email # gonna be a string
    @address = address #gonna be a hash
  end

  def self.all
    customers = []
    CSV.read('./data/customers.csv').map do | customer |
      id = customer[0].to_i
      email = customer[1]
      address = customer[2..5].join(", ")
      customers << Customer.new(id, email, address)
      end
      return customers
    end

    # self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the parameter

  end
