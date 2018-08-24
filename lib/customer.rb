
class Customer

# helper mothods: automatically add reader and writer methods for these varibales. attr_accessor allows for write and read access
attr_reader :id
attr_accessor :email, :address

# constructor: this will automatically called wen Customer.new is invoked
  def initialize(id, email, address)
  # instance varibales/attribute - not visible outside this class
    @id = id
    @email = email
    @address = address
  end

# def customer
#   return
# end

# instance method. invoked using . notation outside class

end
