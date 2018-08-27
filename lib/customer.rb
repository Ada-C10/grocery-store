require_relative 'Order.rb'


#Create a customer class with 3 attributes (Id read only)
class Customer
  attr_reader :id
  attr_accessor :email,:address

  def initialize(id,email,address)
    @id = id #an integer
    @email = email #will be a string
    @address = address #will be a hash
    # address = {:street =>"", :city =>"", :state => "", :zip => ""} # not needed
    # return cust = Customer.new
  end

end

# Initialize should match header. : address in initialize  should be
