require "csv"

CUSTOMERS_FILENAME = "data/customers.csv"

class Customer
  attr_accessor :email, :address
  attr_reader :id

  # Integer, String, Hash
  # { street: "123 Main", city: "Seattle", state: "WA", zip: "98101" }
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
  # return collection of Customers from CSV
    return all_customers = CSV.open(CUSTOMERS_FILENAME).map do |line|
      self.new(line[0].to_i, line[1], {address_1: line[2], city: line[3], state: line[4], zip_code: line[5]})
    end
  end

  def self.find(id)
  # return instance from self.all with id = id
  # return nil if none found
    all_customers = self.all
    return all_customers.find{|obj| obj.id == id}
  end

end
