require 'csv'
require 'awesome_print'
filename = "../data/customers.csv"
class Customer
  @@customers = []
  def initialize(id, email, address)
    # CSV.read(filename, headers:true).map do |line|
      @id = id
      @email = email
      @address = address
      cust_info = [@id, @email, @address]
      @@customers << cust_info
  end
  attr_reader :id
  attr_accessor :email, :address

  def self.all

    return @@customers

  end

end

id = 123
email = "a@a.co"
address = {
  street: "123 Main",
  city: "Seattle",
  state: "WA",
  zip: "98101"}

cust = Customer.new(id, email, address)

# puts Customer.all

id = 223
email = "abc@gmail"
address = {}
cust = Customer.new(id, email, address)
puts Customer.all
