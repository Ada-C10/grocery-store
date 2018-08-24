class Customer

  attr_reader :id
  attr_accessor :email, :del_address

  @id: 123
  @email: "abc@gmail.com"
  @del_address: {123 4th st, ktown, AK}

def initialize(customer_attributes)
  @id = customer_attributes[:id]
  @email = customer_attributes[email:]
  @del_address = customer_attributes[del_address:]
end


end
