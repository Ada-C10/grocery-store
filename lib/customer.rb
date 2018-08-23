# Create a class called `Customer`. Each new Customer should include the following attributes:
# - ID, a number
# - Email address, a string
# - Delivery address, a hash
#
# ID should be _readable_ but not _writable_; t
# he other two attributes can be both read and written.

require 'pry'
class Customer
  attr_reader :id
  attr_accessor :email, :address

  #   # TODO Error handling on attributes_hash variable

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
    # @street = address[:street]
    # @city = address[:city]
    # @state = address[:state]
    # @zip = address[:zip]
  end

end
#
cassy = Customer.new(5, "cassya@gmail.com", {
  street: "123 sunny lane",
  city: "Palmer",
  state: "AK",
  zip: "99645"
  })
