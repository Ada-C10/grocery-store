# ID, a number
# Email address, a string
# Delivery address, a hash
require 'pry'
require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  #initialize class variable
  # @@customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all

    customers = CSV.open('data/customers.csv', "r").map do |customer|

      Customer.new(customer[0].to_i, customer[1], address = {street: customer[2], city: customer[3], state: customer[4], zip: customer[5]})

    end
    # binding.pry
    return customers
  end


  #populates customers class variable with cvs data by calling self.all method
  # @@customers = self.all

  def self.find(id)
    ##or equals will assign if nil
    #otherwise skip
    #false, set.. otherwise, skip
    @@customers ||= Customer.all

    #find the matching element in array and return it if it's there
    #else implict return of nil
    found_customer = @@customers.find do |customer|

      #conditional
      customer.id == id

    end

    return found_customer
  end


  # customer array
  #     ID = 123
  #     EMAIL = "a@a.co"
  #     ADDRESS = {
  #       street: "123 Main",
  #       city: "Seattle",
  #       state: "WA",
  #       zip: "98101"
  #     }



end
