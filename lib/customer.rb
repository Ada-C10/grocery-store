require 'csv'
require 'awesome_print'
require 'pry'

class Customer
attr_reader :id
attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = CSV.read('data/customers.csv').map do |customer|
      customer
    end

    all_customers = customers.map do |customer|
      @id = customer[0].to_i
      @email = customer[1]
      @address = {:street => customer[2], :city => customer[3], :state => customer[4], :zip => customer[5]}
      Customer.new(@id, @email, @address)
    end

    return all_customers
  end

  def self.find(id)
    customers = Customer.all

    existing_customer = customers.detect do |customer|
      customer.id == id
    end

  #  Error handling? --> but does not pass test
    # if existing_customer == nil
    #   raise ArgumentError, "ID not found"
    # else
    #   return existing_customer
    # end

    return existing_customer
  end



end





#
#
#   end
#
# end
#
# # address = {
# #   street: "123 Main",
# #   city: "Seattle",
# #   state: "WA",
# #   zip: "98101"
# # }
# # customer = Customer.new(123, "a@a.co", address)
puts Customer.find(1)
