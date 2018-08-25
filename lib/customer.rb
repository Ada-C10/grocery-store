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
    @@customers = CSV.open('data/customers.csv', 'r').map do |row|
      id = row[0].to_i
      email = row[1]
      address = {
        :street => row[2],
        :city => row[3],
        :state => row[4],
        :zip => row[5]
      }
      Customer.new(id, email, address)
    end
    return @@customers
  end

  def self.find(id)
    x = ""
    @@customers.length.times do |i|
      if @@customers[i].id == id
        x = @@customers[i]
        break
      else
        x = nil
      end
    end
    return x
  end
end
