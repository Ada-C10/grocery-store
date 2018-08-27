#class Cusotmer
require 'csv'
require 'awesome_print'
require 'pry'

class Customer

  #@@id = 123

  attr_reader :id
@@customers = []
  attr_accessor :email, :address

  def initialize(id, email, address = {street: "", city:"", state: "", zip:""})
    @id = id
    @email = email
    @address = address
  end


  def self.all(filename)
    CSV.open('./data/customers.csv').map do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {street: customer[2], city: customer[3], state: customer[4], zip: customer[5]}
      @@customers<<customer.self(id,email, address)
    end
    return @@customers
  end

ap @@customers

end


  #def self.all(customers.csv)
  #  CSV.open('./data/customers.csv').map do |customer|
    #  id = customer[0].to_i
    #  email = customer[1]
    ##  @@customers<<customer.self(id,email, address)
    #end
  #  return @@customers
  #end

#ap @@customers
