require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #<-- int
    @email = email #<-- string
    @address = address  #<-- hash

  end

  def self.all

    all_customers = CSV.open("data/customers.csv", 'r').map do |line|
      address = {
        street: line[2],
        city: line[3],
        state: line[4],
        zip: line[5]
      }

      cust_hash = {
        id: line[0].to_i,
        email: line[1],
        address: address
      }

      new_cust = Customer.new(cust_hash[:id], cust_hash[:email], cust_hash[:address])
    end

    return all_customers
  end

  def self.find(id)
    customers = self.all

    return customers.find { |customer| customer.id == id }
  end
end


# ID = 123
# EMAIL = "a@a.co"
# ADDRESS = {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# }
#
# products = { "banana" => 1.99, "cracker" => 3.00 }
#
# customer = Customer.new(ID, EMAIL, ADDRESS)
# puts customer.address
#
# id_2 = 44
# email_2 = "omg@gmail.com"
# address_2 = {
#   street: "306 blanchard st",
#   city: "Seattle",
#   state: "WA",
#   zip: "98121"
# }
#
# customer_2 = Customer.new(id_2, email_2, address_2)
# puts customer_2.address
# puts "--now for both--"
#
# print Customer.all
# order = Order.new(1337, products, customer)
#
#
# puts order.total

# puts Customer.find(34)
