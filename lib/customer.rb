require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = CSV.open("data/customers.csv", 'r').map do |line|
      Customer.new(line[0].to_i, line[1], {:street => line[2], :city => line[3], :state => line[4], :zip => line[5]})
    end
    return customers
  end

  def self.find(id)
    customer_list = Customer.all
    customer = customer_list.find do |line|
      line.id == id
    end
    return customer
  end
end
