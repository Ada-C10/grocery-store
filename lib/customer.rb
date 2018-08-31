require 'csv'
require 'awesome_print'


class Customer

  attr_reader :id #readable only
  attr_accessor :email, :address #readable and writable

  def initialize(id, email, address_hash) #instances variables
    @id = id
    @email = email
    @address = address_hash
  end

  def self.all() #returns collection of customer instances, self = not referring to particular customer
    customers = [] #will store customers from CSV
    CSV.foreach("data/customers.csv") do |row| #load csv, iterate row by row
    customers << Customer.new(row[0].to_i,row[1],row[2..5].join(" ")) #convert customer id to integer and join together address and shovel to array
    end
    return customers
  end

  def self.find(id) # returns an instance of Customer by ID#
    customer = self.all.find { |cust| cust.id == id } #self.all = all customers, .find = lookup customer by id#
  end
end
