require "csv"
require "ap"
require "pry"

class Customer

  attr_reader :id
  attr_accessor :email, :address

  @@customer = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    @@customer = []
    CSV.foreach("data/customers.csv") do |customer|
      address = {
        street: customer[2],
        city: customer[3],
        state: customer[4],
        zip: customer[5].strip,
      }
      @@customer << Customer.new(customer[0].to_i, customer[1], address)
    end
    return @@customer
  end

  def self.find(num)
    @@customer = Customer.all
    return @@customer.find {|customer| customer.id == num}
  end

end
