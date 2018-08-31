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

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address #addres1/street, city, state, zip
  end

  def self.all
    @@customers = [] #empty array to hold customers

    CSV.open('data/customers.csv', headers: true).each do |customer| #added headers to csv for hash creation
      customer_info = customer.to_h #from csv row object to hash
      address = customer_info.slice("street", "city", "state", "zip") #creates hash called address with sliced info

      @@customers << Customer.new(customer_info["id"].to_i, customer_info["email"], address) #id, email, and new address hash is pushed into customers array
    end

    return @@customers
    #CREATING customer instances with the info from the CSV
  end

  def self.find(id)
    Customer.all #invokes all to populate @@customer

    @@customers.each do |customer|
      return customer if id == customer.id
    end

    return nil #nil if no customer id found
  end


end













#
