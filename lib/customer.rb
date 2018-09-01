require 'pry'
require 'csv'
require 'ap'

class Customer
  attr_reader :id
  attr_accessor :email, :address
  # initalize
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end
  # define a method to read from CSV file and create a list of customers
  def self.all
    all_customers = []

    CSV.open('data/customers.csv', 'r').map do |line|
      customer_info = line.to_a
      address_in = {street: customer_info[2], city: customer_info[3], state: customer_info[4], zip: customer_info[5] }
      new_customer = self.new(customer_info[0].to_i,customer_info[1], address_in)
      all_customers.push(new_customer)
    end

    return all_customers
  end
  # find a customer by using the customer id.
  def self.find(id)
    all_customers = self.all
    customer_found = all_customers.select {|customer| customer.id == id}
    if customer_found != nil
      return customer_found[0]
    end
  end

end
