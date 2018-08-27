require 'pry'
require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #must be num
    @email = email #must be string
    raise ArgumentError.new("The email address must be of class String") unless @email.class == String
    @address = {:street => address[:street], :city => address[:city], :state => address[:state], :zip => address[:zip]}
  end

  # returns a collection of Customer instances,representing all of the Customers described in the CSV file
  def self.all
    CSV.open('data/customers.csv', 'r').map do |row|
      Customer.new(row[0].to_i, row[1], address = {street: row[2], city: row[3], state: row[4], zip: row[5]})
    end
  end

  # returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
  def self.find(id)
    self.all.find do |customer|
      customer.id == id
    end
  end


end
