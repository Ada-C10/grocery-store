
class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #<-- int
    @email = email #<-- string
    @address = address  #<-- hash
  end

end
