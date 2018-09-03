class Customer

  attr_reader :ID
  attr_accessor :email, :address

  def initialize(id, email, address)
  @id = :ID
  @email = email
  @address =  address
  end

  def address
    address = {
        street: "123 Main",
        city: "Seattle",
        state: "WA",
        zip: "98101"}
  end
  def summary
    return "#{@ID},#{@email}, #{@address}"
  end
end
new_customer = Customer.new(3,"hat@hat.com","123 hat street")
puts new_customer.summary
