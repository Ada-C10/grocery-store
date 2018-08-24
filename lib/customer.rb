require 'csv'
require 'awesome_print'

require_relative 'data/customers.csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  @@customer_collection = []

def initialize(id, email, address)
  @id = id
  @email = email
  @address = address
end

def id
  return @id
end

def email
  return @email
end

def delivery_address
  return @address
end

def self.all
  CSV.open("data/customers.csv", "r").map do |line|
    id = line[0]
    email = line[1]
    address_street = line[2]
    address_city = line[3]
    address_state = line[4]
    address_zip = line[5]

    full_address = {
      street: address_street,
      city: address_city,
      state: address_state,
      zip: address_zip
    }

    new_customer = Customer.new(id, email, full_address)
    @@customer_collection << new_customer

  end
  return @@customer_collection
end

end
