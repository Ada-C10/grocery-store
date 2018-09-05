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
    @id = id
    @email = email
    @address = address
  end


  ####################
  #WAVE #2
  ####################


  def self.all
    data1 = CSV.read("/Users/ada/ada/Projects/grocery-store/data/customers.csv")
    all_customers = []
    data1.each do |row|
      customer_id = row[0].to_i
      email = row[1]
      address = {}
      address[:street] = row[2]
      address[:city] = row[3]
      address[:state] = row[4]
      address[:zip_code] = row[5]

      all_customers << Customer.new(customer_id, email, address)
    end
    return all_customers
  end

  def self.find(id)
    # customer = self.all
    self.all.each do |customer|
      if customer.id == id
        return customer
      end
    end
  return nil
  end

end
