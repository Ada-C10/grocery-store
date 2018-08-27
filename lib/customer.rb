class Customer
  attr_accessor :email, :address
  attr_reader :id

# integer, string, hash
# { street: "123 Main", city: "Seattle", state: "WA", zip: "98101" }
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

end
