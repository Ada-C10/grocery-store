require "csv"
require "pry"
require "awesome_print"

class Customer

  attr_reader :id, :email, :address
  attr_writer :email, :address

  @@customer = []

  def initialize(id, email, address)
    @id =  id
    @email = email
    @address = {:street => address[:street], :city => address[:city],  :state => address[:state], :zip => address[:zip]}
  end

  def self.all

    @@customer = CSV.open('data/customers.csv', 'r').map do |line|
      id = line[0].to_i
      email = line[1]
      address = {
        street: line[2],
        city: line[3],
        state: line[4],
        zip: line[5]
      }

      Customer.new(id, email, address)
    end
    return @@customer
  end


  def self.find(id)

    # return @@customer[id - 1]
    if @@customer.size == 0
      self.all
    end

    customer = @@customer.find do |instance|
      instance.id == id
    end
    return customer
  end

end
