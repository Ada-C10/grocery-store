require "csv"
require "pry"

class Customer

@@customer = []

  attr_reader :id, :email, :address
  attr_writer :email, :address

  def initialize(id, email, address)
    @id =  id
    @email = email
    @address = {:street => address[:street], :city => address[:city],  :state => address[:state], :zip => address[:zip]}
  end

  # def customer_data
  #   @@customer = CSV.open('data/customers.csv', 'r').map do |line|
  #     self.new (line[0].to_i, line[1], {address1:line[2]}, city:line[3], state:line[4], zip:line[5]})
  #   end
  #   return @@customer
  # end

  def self.all
  @@customer = CSV.open('data/customers.csv', 'r').map do |line|
      Customer.new( @id = line[0], @email = line[1],
        @address = {
          street: line[2],
          city: line[3],
          state: line[4],
          zip: line[5]
        })
    end
    return @@customer
  end


end
