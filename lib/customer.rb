require_relative '../lib/order'
require 'csv'

class Customer
  @@customers = []

  attr_reader :id
  attr_accessor :email, :address
  ID = 0
  EMAIL = ""
  ADDRESS = {}

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    CSV.open('data/customers.csv', 'r').map do |row|
      cust = Customer.new(row[0].to_i, row[1], address = {:street => row[2], :city => row[3], :state => row[4], :zip => row[5]
      })
      @@customers << cust
    end
    return @@customers
  end

end
