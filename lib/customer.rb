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
  customer_collection = []

  CSV.open("data/customers.csv", "r").map do |line|
    # Each comma separated value in the line is assigned to a different variable
    id = line[0].to_i
    email = line[1].to_s
    address_street = line[2].to_s
    address_city = line[3].to_s
    address_state = line[4].to_s
    address_zip = line[5].to_s

    full_address = {
      street: address_street,
      city: address_city,
      state: address_state,
      zip: address_zip
    }

    # Data from each line in the CSV is used as arguments to create an instance of Customer
    new_customer = Customer.new(id, email, full_address)

    customer_collection << new_customer
  end
  return customer_collection
end

def self.find(id)
  # Calling the Customer.all method which returns an array of customer objects
  all_customers = Customer.all

  # Iterating through the array of customer objects, and for each customer object locate it's id and see if it equals the id parameter
  index = 0
  while index < all_customers.length
    if all_customers[index].id == id
      return all_customers[index]
    end
  index += 1
  end

  return nil
end

end



# TEST
# run_test = Customer.all
# puts "#{run_test}"
#
# index = 0
# while index < run_test.length
#   x = run_test[index]
#   puts "Customer number: #{x.id}, email: #{x.email}"
#   index += 1
# end
#
# find_customer = Customer.find(1)
# puts "Customer id: #{find_customer.id}, email: #{find_customer.email}"
