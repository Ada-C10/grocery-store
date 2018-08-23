class Customer

  attr_reader :id
  attr_accessor :email, :address

def initialize(id, email, address)
  @id = id
  @email = email
  @address = address
end

def id
  return @id
end

def email
  return @email
end

def delivery_address
  return @address
end

end
