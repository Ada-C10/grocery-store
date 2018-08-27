require 'csv'
require 'awesome_print'

class Customer
  @@customers = []
  def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
      @@customers << self
  end
  attr_accessor :id
  attr_accessor :email, :address

  def self.all
    return @@customers
  end

  def self.find(id)
    working_array = Customer.all
    working_array.each do |cust|
    if cust[0] == id
      return cust
    end
  end
  end

end

CSV.open("../data/customers.csv",'r').map do |line|
  id = line[0].to_i
  email = line[1]
  address = {street: "#{line[2]}", city: "#{line[3]}", state: "#{line[4]}", zip:  "#{line[5]}"}
  Customer.new(id, email, address)
end

ap Customer.all
