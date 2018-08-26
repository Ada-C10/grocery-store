class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #must be num
    @email = email #must be string
    raise ArgumentError.new("The email address must be of class String") unless @email.class == String
    @address = {:street => address[:street], :city => address[:city], :state => address[:state], :zip => address[:zip]}
  end



end

# kay = Customer.new(28, "kay@mail.com", :street => "2920", :city =>"seattle", :state =>"wa", :zip =>98192)
