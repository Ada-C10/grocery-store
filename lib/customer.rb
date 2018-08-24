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

  def self.all
    # returns collection of customer instances representing all Customers from CSV
    customers_raw_data = CSV.read('data/customers.csv')
    customers = customers_raw_data.map do |customer|
      self.new(customer[0].to_i, customer[1], {street: customer[2], city: customer[3], state: customer[4], zip: customer[5]})
    end
    return customers
  end

  def self.find(id)
    # returns an instance of Customer with ID
    # invokes Customer.all (does not parse through CSV data)
    # if ID doesn't exist, what to do
  end

end
