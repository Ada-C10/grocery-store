require 'pry'
require 'csv'
require 'awesome_print'

class Customer
attr_reader :id
attr_accessor :email, :address
@@customers = []

def initialize(id, email, address)
  @id = id
  @email = email
  @address = {:street => address[:street], :city => address[:city], :state => address[:state], :zip => address[:zip]}
end

# return instances of customers from a CSV file
#### assign variables first, and create instance at outside of loop, more clear, and similar to test structure
##### assign it in a hash tighting it to the column headers 
def self.all
  @@customers = CSV.read('data/customers.csv').map {|line| line}
  @@customers = @@customers.map do |array|
    Customer.new(id = array[0].to_i, email = array[1],
      address = {
        :street => array[2],
        :city => array[3],
        :state => array[4],
        :zip => array[5]
        })
    end
  return @@customers
end

    # input: id of customer
    # return instance of customer based on id
def self.find(id)
  customers = self.all
  customer = customers.select {|instance| instance.id == id} # returns instance in array
    return customer[0] # select and return instance
end

end
