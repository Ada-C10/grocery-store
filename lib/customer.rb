require 'csv'
require 'awesome_print'
# ID, a number = yes
# Email address, a string = yes
# Delivery address, a hash = yes
# ID should be readable but not writable; the other two attributes can be both read and written. = yes
# re customers.csv
# Parse the list of products into a hash
# This would be a great piece of logic to put into a helper method
# You might want to look into Ruby's split method
# Turn the customer ID into an instance of Customer
# Didn't you just write a method to do this?
# We recommend manually copying the first product string from the CSV file and using pry to prototype this logic


class Customer

  attr_reader :id
  attr_accessor :email, :address

  @@customers = [] #empty array to hold customers

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
    # @@customers << self
  end

  def self.all
    # returns a collection of Customer instances, representing all of the Customer described in the CSV file
  end

  # def self.find(id)
  #   # returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
  #   # should not parse the CSV file itself. Instead it should invoke Customer.all and search through the results for a customer with a matching ID.
  #   all_info = []
  #   all_info << Customer.all
  #   return all_info.select{|@id| id}
  #
  # end
end
