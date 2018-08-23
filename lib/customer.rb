class Customer

  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email_address, delivery_address)
    @email = email_address
    @address = delivery_address
    @id = id
  end


end
