require 'csv'
require 'awesome_print'
require 'pry'

class Customer

  @@customers = []

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
    create_data
    # binding.pry
  end

  def create_data
  return  @@customers.push(self)
  end


  def self.all
    return @@customers
  end

  def self.find(id)
    @@customers.length

    @@customers.each do |customer|
      if customer.id == id
        return customer
      end
    end
    puts ""
  end
end


CSV.read('../data/customers.csv').each do |cust_row|

  address = {}

  address[:street] = cust_row[2]
  address[:city] = cust_row[3]
  address[:state] = cust_row[4]
  address[:zip] = cust_row[5]

 Customer.new(cust_row[0].to_i, cust_row[1], address)
end




# a = Customer.all
# ap a
#
#
# # a = Customer.new(123, 6, {
# #   street: "123 Main",
# #   city: "Seattle",
# #   state: "WA",
# #   zip: "98101"
# # })
# #
# # ap a

#
# first = Customer.find(1)
# ap first
