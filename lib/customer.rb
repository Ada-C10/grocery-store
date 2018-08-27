require "csv"
require "ap"
require "pry"

class Customer
  attr_reader :id, :email, :address
  @@customers = []
  @@found_customer = nil

  def initialize(id, email, address)
    @id = id  #number
    @email = email  #string
    @address = address  #hash
  end

  def self.all

    @@customers = CSV.open("data/customers.csv" , "r").map do |line|
        id = line[0].to_i
        email = line[1]
        address = {
          street: line[2],
          city: line[3],
          state: line[4],
          zip: line[5]}

    Customer.new(id, email, address)
    end
      return @@customers
  end
  # test = Customer.all
  # puts "#{test}"

  def self.find(id)
    Customer.all.each do |customer|
      if customer.id == id
        return customer
      else
        # Not sure why this fails test 2 on the Customer.find test
        return nil
      end
    end
  end

end
