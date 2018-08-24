# Create a class called Customer. Each new Customer should include the following attributes:
#
# ID, a number
# Email address, a string
# Delivery address, a hash
# ID should be readable but not writable; the other two attributes can be both read and written.


class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize (id, email, address)
    @id = id # gonna be an int
    @email = email # gonna be a string
    @address = address #gonna be a hash
  end


end
