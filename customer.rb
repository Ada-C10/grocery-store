#class Cusotmer
require 'csv'
require 'awesome_print'
require 'pry'

class Customer


  attr_reader :id

  attr_accessor :email, :address

  def initialize(id, email, address = {street: "", city:"", state: "", zip:""})
    @id = id
    @email = email
    @address = address
  end

  def self.all
    CSV.open('./data/customers.csv').map do |customer|
      id =  customer[0].to_i
      email = customer[1]
      address = {street: customer[2], city: customer[3], state: customer[4], zip: customer[5]}

      Customer.new(id,email, address)
    end
  end
end

def self.find(id)
  all_customers = self.all
  all_customers.each do |customer|
  if customer.id == id
    return customer
  end
end
end
