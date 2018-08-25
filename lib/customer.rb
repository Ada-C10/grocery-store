require 'csv'

CSV.open("data/customers.csv",'r').each do |line|
  puts line
end

class Customer
  attr_reader :id

  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    puts self
  end

  def self.find(id)
    if @id == Customer.id
      return @customer
    end
  end

end
