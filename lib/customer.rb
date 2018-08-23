class Customer

  attr_accessor :email_address, :delivery_address
  attr_reader :id_number

  def initialize(email_address, delivery_address, id_number)
    @email_address = email_address
    @delivery_address = delivery_address
    @id_number = id_number
  end
  

end
