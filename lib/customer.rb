# ID, a number = yes
# Email address, a string = yes
# Delivery address, a hash = yes
# ID should be readable but not writable; the other two attributes can be both read and written. = yes
class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all

    # returns a collection of Customer instances, representing all of the Customer described in the CSV file
  end

  # def self.find(id)
  #   # returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
  #   # should not parse the CSV file itself. Instead it should invoke Customer.all and search through the results for a customer with a matching ID.
  #   all_info = []
  #   all_info << Customer.all
  #   return all_info.select{|@id| id}
  #
  # end
end
