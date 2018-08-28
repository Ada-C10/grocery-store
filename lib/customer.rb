require_relative 'Order'
require 'csv'
######################
#WAVE #1 - all test passing
######################

#Create a customer class with 3 attributes (Id read only)
class Customer
  attr_reader :id
  attr_accessor :email,:address

  def initialize(id,email,address)
    @id = id #an integer
    @email = email #will be a string
    @address = address #will be a hash
  end
end

  ####################
  #WAVE #2 - incomplete - tests are not all passing and I didn't write my tests
  ####################


  # def self.all
  #   all_customers = []
  #   CSV.read("/Users/ada/ada/Projects/grocery-store/data/customers.csv").each do |row|
  #     address = {}
  #     customer_id = row[0].to_i
  #     email = row[1]
  #     address[:street] = row[2]
  #     address[:city] = row[3]
  #     address[:state] = row[4]
  #     address[:zip_code] = row[5]
  #
  #     all_customers << Customer.new(customer_id, email, address)
  #   end
  #   return all_customers
  # end
