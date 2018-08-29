require 'csv'
require 'pry'
require 'awesome_print'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # Reads CSV and uses the data to create new instances of the Customer class
  # Returns an array of all the Customer instances
  def self.all
    customer_data = []
    customer_data = CSV.open('data/customers.csv', 'r').map do |line|
      line
    end

    all_customers = []
    customer_data.each do |person|
      all_customers << self.new(person[0].to_i, person[1], {street: person[2], city: person[3], state: person[4], zip: person[5]})
    end

    return all_customers
  end

  # Searches through all Customer instances to find a match given the id
  def self.find(id)
    return self.all.find { |customer| customer.id == id }
    # all_customers = self.all
    # all_customers.each do |customer|
    #   if customer.id == id
    #     return customer
    #   end
    # end
    # return nil
  end

end
