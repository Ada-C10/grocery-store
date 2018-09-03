
require 'pry'
require 'csv'
require 'awesome_print'
class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

    # Returns collections of Customer instances
      # Representing all Customers in CSV file
  def self.all
    customer_array_of_hashes = CSV.open("data/customers.csv", headers: true).map do |item|
      item.to_h
    end

    # Creating array of Cusomter instances from array of customer hashes
      # EACH hash = Create a new instance CUSTOMER class
    customer_array = customer_array_of_hashes.map do |customer|
     # Using CSV hashes for Customer values
      Customer.new(id = customer["id"].to_i, email = customer["email"], {
        street: customer["street"],
        city: customer["city"],
        state: customer["state"],
        zip: customer["zip"]
         }
       )
    end
    return customer_array
  end

  # RETURNING an instance of Customer where values
    # in id field in the CSV match the passed parameter
  def self.find(id)
    # Returns Customer if id is found
    return self.all.find { |customer| customer.id == id }
  end
end
