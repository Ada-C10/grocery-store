require 'csv'
require 'pry'
class Customer
  attr_reader :id, :email, :address
  attr_writer :email, :address

  @@customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = {:street => address[:street] , :city => address[:city], :state => address[:state] , :zip => address[:zip] }
  end

  def self.make_customer_list
    @@customers = CSV.open('data/customers.csv', 'r').map do |line|
      self.new(line[0].to_i, line[1], {address1:line[2], city:line[3], state:line[4], zip:[5]})
    end
  end

  def self.all
    self.make_customer_list
    return @@customers
  end

  def self.find(id)
    self.all
    return @@customers.find {|customer| customer.id == id}
  end
end
