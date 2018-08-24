class Customer

  attr_reader :id
  attr_accessor :email, :address

  @@customer = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    return @@customer
  end

  def self.find(id)
    return @@customer.find {|cust| cust.id == id}
  end

end
