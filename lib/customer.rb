class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(ID, EMAIL, ADDRESS)
    @ID = ID
    if @ID.class != integer
      puts "Not a num"
    end

    @EMAIL = EMAIL
    if @EMAIL.class != string
      puts "not a string"
    end

    @ADDRESS = ADDRESS
    if @ADDRESS.class != hash
      puts "not a hash of address data"
    end
  end


end
