require 'csv'
require 'pry'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize (id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = CSV.read('./data/customers.csv').map do |customer_array|
      id = customer_array[0].to_i
      email = customer_array[1]
      address = customer_array[2..5].join(", ")
      Customer.new(id, email, address)
    end
    return customers
  end

  def self.find(id)
    self.all.select do |customer_array|
      return customer_array if customer_array.id == id
    end
    return nil
  end
end
