class Customer
  attr_reader :id :email :delivery_address
  attr_writer :email :delivery_address

  def initialize(id, email, street, apt, city, state, zip)
    @id = id #number
    @email = email#string
    @delivery_address = {street: street,
                         appt: ||= nil,
                         city: city,
                         state: state,
                         zip: zip} ## how do you take in the argument and format into hash
  end

  def format_delivery_address(delivery_address)
    delivery_address_array = delivery_address.split(',')
    @delivery_address[:street] = delivery_address_array(0)
    @delivery_address[:city] = delivery_address_array(1)
    @delivery_address[:state] = delivery_address_array(2)
    @delivery_address[:zip] = delivery_address(3)
  end

end

amanda = Customer.new(1021, 'amanda.ungco@gmail.com', '410 11th ave, seattle, wa, 98122')
p amanda.delivery_address
