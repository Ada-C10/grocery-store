# require_relative '../lib/orders'
require 'pry'
require 'csv'
# data/customers.csv'
#if user dosnt have ID...find(ifnone = nil) { |obj| block } → obj or nil
# ruby lib/customer.rb  <--put this in terminal to practice run this
#be in grocery store to run rake, make sure all other things are commented out

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #must be num
    @email = email #must be string
    raise ArgumentError.new("The email address must be of class String") unless @email.class == String
    @address = {:street => address[:street], :city => address[:city], :state => address[:state], :zip => address[:zip]}
  end

  # self.all - returns a collection of Customer instances,
  # representing all of the Customers described in the CSV file
  def self.all
    CSV.open('data/customers.csv', 'r').map do |row|
      Customer.new(row[0].to_i, row[1], address = {street: row[2], city: row[3], state: row[4], zip: row[5]})
    end
  end

  # self.find(id) - returns an instance of Customer where
  # the value of the id field in the CSV matches the passed parameter
  def self.find(id)
    self.all.find do |customer|
      customer.id == id
    end
  end


end
