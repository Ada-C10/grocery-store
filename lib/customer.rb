class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize (id, email, address)
    @id = id  #number
    @email = email  #string
    @address = address  #hash
  end

end

# test = Customer.new(123, "a@a.co", {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# } )
#
# puts test.id #123
# puts test.email #a@a.co
# puts test.address #{:street=>"123 Main", :city=>"Seattle", :state=>"WA", :zip=>"98101"}
