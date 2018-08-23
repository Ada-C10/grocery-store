require 'csv'
require 'ap'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)

    @id = id
    @email = email
    @address = address
  end

  def self.all


    CSV.open("data/customers.csv", "r").map do |row|
      address = row[2] + ' ' + row[3] + ' ' +  row[4] + ' ' +  row[5]
      Customer.new(row[0], row[1], address)
    end

  end

  def self.find(id)

    customers = self.all
    return customers.find{ |customer| customer.id == id }

  end

end
