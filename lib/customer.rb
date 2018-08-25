require 'pry'
require 'csv'
require 'ap'

class Customer
  attr_reader :id
  attr_accessor :email, :address
  @@all_customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
    @@all_customers << self
  end

  def self.all
    CSV.open('data/customers.csv', 'r').map do |line|
      customer_info = line.to_a
      address_in = {street: customer_info[2], city: customer_info[3], state: customer_info[4], zip: customer_info[5] }
      new_customer = self.new(customer_info[0].to_i,customer_info[1], address_in)

    end

  return @@all_customers
  end
end
