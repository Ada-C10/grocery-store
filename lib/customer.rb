class Customer
  attr_reader :ID, :Email_address, :Delivery_address
  attr_writer :Email_address, :Delivery_address

  def initialize(id, email, delivery_address)
    @ID = id
    @Email_address = email
    @Delivery_address = {delivery_address}
  end
end
