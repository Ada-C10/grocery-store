require 'csv'
require 'awesome_print'
filename = "data/customers.csv"
class Customer
  @@customers = []
  def initialize(id, email, address)
    filename = "../data/customers.csv"
    # CSV.read(filename, headers:true).map do |line|
      @id = id
      @email = email
      @address = address
      @filename = filename
  end
  attr_reader :id
  attr_accessor :email, :address

  def add_instances
    CSV.read(@filename).each do |line|
      if @id.to_s == line[0]
        @@customers << line
      end
    end
  end

  def self.all
    return @@customers
  end

end

id = 21
email = "a@a.co"
address = {
  street: "123 Main",
  city: "Seattle",
  state: "WA",
  zip: "98101"}

cust = Customer.new(id, email, address)
cust.add_instances

# puts Customer.all

id = 32
email = "abc@gmail"
address = {}
cust2 = Customer.new(id, email, address)
cust2.add_instances

ap Customer.all
