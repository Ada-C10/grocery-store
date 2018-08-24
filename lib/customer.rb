class Customer
  attr_reader :id
  attr_accessor :email, :address
  def initialize(ID, EMAIL, ADDRESS)
    @ID = ID
    @EMAIL = EMAIL
    @ADDRESS = ADDRESS
  end
end
