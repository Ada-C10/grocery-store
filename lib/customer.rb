require 'csv'
class Customer
  attr_reader :id, :email, :address
  attr_writer :email, :address

@@customers = []
@@Customerdata = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = {:street => address[:street] , :city => address[:city], :state => address[:state] , :zip => address[:zip] }
  end

def load_data
  @@Customerdata = CSV.open('data/customers.csv', r).map do |line|
end

  def self.all
      @@customerdata.each do |customer|
      @@customers << Customer.new
    end
    return @@customers
end
  end
end
