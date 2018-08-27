require 'csv'
require 'awesome_print'

# class includes attributes of id, email & address
class Customer
  # class variable defined
  @@customers = []

  # method initializes instance variables
  def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
      # ensures that only 35 instances are stored in class variable
      if @id < 36
        @@customers << self
      end
  end
  attr_accessor :id
  attr_accessor :email, :address

  # returns list of all customer instances
  def self.all
    return @@customers
  end

  # helps find instance by searching with id
  def self.find(id)
    if id < 1 || id > 35
      return nil
    end
    working_array = Customer.all
    working_array.each do |cust|

    if cust.id == id
      return cust
    end
    end
  end

end

# creates instaces based on input from csv file
CSV.open("data/customers.csv",'r').map do |line|
  id = line[0].to_i
  email = line[1]
  address = {street: "#{line[2]}", city: "#{line[3]}", state: "#{line[4]}", zip:  "#{line[5]}"}
  Customer.new(id, email, address)
end
