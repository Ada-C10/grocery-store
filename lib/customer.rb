require 'csv'
require 'pry'

# Wave 1 customer creations

class Customer
  attr_reader :id
  attr_accessor :email, :address

  @@customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  #  Wave 2
  # everytime the mini test spec is run it randomly chooses the order of operation. If find comes before the method all then it fails.
  # In order to mitigate that problem Zac showed me a trick to make a global varaible that loads the data ones and saves it in the class to be used using the following method.

  def save
    @@customers << self
  end

  def self.all
    return @@customers
  end

  # class method that returns an instance of customer by adding
  # has one paramenter id
  # it should invote customer.all and search
  def self.find(id)
    # # # @@customers ||= Customer.all
    # # # customers = Customer.all
    # customer = @@customers.find{|id| id == id}
    # return  customer

    # return @@customers.find{|id| id == id}
    @@customers.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end
end


# creating a global varaible outside the class to be called in in the class above to load the data ones
CSV.read("data/customers.csv").map do |line|
  id = line[0].to_i
  email = line[1]
  address = {
    street:  line[2],
    city:  line[3],
    state:  line[4],
    zip:  line[5]
  }

  customer = Customer.new(id, email, address)
  customer.save
end
