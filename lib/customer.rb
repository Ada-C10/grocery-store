require 'csv'
require 'pry'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customer_list = []
    CSV.read('data/customers.csv').each do |line|
      customer_list << Customer.new(line[0].to_i, line[1], { street: line[2], city: line[3], state: line[4], zip: line[5] })
    end
    return customer_list
  end

  def self.find(id)
    return self.all[id - 1]
  end
end
