require 'csv'

class Customer
  @@all = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  attr_reader :id, :address
  attr_accessor :email

  def self.all
    @@all = CSV.open('data/customers.csv', 'r', headers: false).map do |line|
      self.new(line[0].to_i, line[1], {street: line[2], city: line[3], state: line[4], zip: line [5]})
    end
  end

  def self.find(id)
    customers = Customer.all
    found = nil
    customers.each { |item| found = item if item.id.to_i == id }
    return found
  end

end
