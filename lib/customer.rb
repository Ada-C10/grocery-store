# Create a class called `Customer`. Each new Customer should include the following attributes:
# - ID, a number
# - Email address, a string
# - Delivery address, a hash
#
# ID should be _readable_ but not _writable_; t
# he other two attributes can be both read and written.

require 'pry'
require 'csv'
require 'awesome_print'
class Customer
  attr_reader :id
  attr_accessor :email, :address

  #   # TODO Error handling on attributes_hash variable

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # self.all -
    # Returns collections of Customer instances
      # Representing all Customers in CSV file

  def self.all
    customer_array_of_hashes = CSV.open("data/customers.csv", headers: true).map do |item|
      item.to_h
    end

    puts "Customer array of hashes"
    ap customer_array_of_hashes
    # Create array of customers from array of customer hashes
      # Each hash = Create a new customer
    customer_array = customer_array_of_hashes.map do |customer|
    #   # Using CSV hashes for Customer values
      Customer.new(id = customer["id"], email = customer["email"], {
        street: customer["street"],
        city: customer["city"],
        state: customer["state"],
        zip: customer["zip"]
         }
       )
    end
    ap customer_array
    return customer_array
    binding.pry
  end
  #   # Returns collection of Customer instances
  #     # From CSV file

  # self.find(id) - Returns an instance of Customer where values
    # in id field in the CSV match the passed parameter
    # Customer.find should use Customer.all to search
      # for a customer with a matching id

end
#
cassy = Customer.new(5, "cassya@gmail.com", {
  street: "123 sunny lane",
  city: "Palmer",
  state: "AK",
  zip: "99645"
  })

binding.pry
