require_relative '../lib/order'

class Customer
  attr_reader :id
  attr_accessor :email, :address
  ID = 0
  EMAIL = ""
  ADDRESS = {}

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
    # if @ID.class != integer
    #   puts "Not a num"
    # end
  end


  # if @EMAIL.class != string
  #   puts "not a string"
  # end


  # if @ADDRESS.class != hash
  #   puts "not a hash of address data"
  # end
  # end


end
