require 'csv'
require 'awesome_print'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
     all =  CSV.open('data/customers.csv', 'r').map do |customer|
        Customer.new(customer[0].to_i, customer[1], { street: customer[2],
        city: customer[3], state: customer[4], zip: customer[5]})
    end
    return all
  end

  def self.find(id)
    found = Customer.all.select { |customer| customer.id == id }

     if found == []
        return nil #"Customer not found"
      else
        return found
      end
  end
end

# maryam = Customer.new(2, 'maryam@gmail.com', {street: "605 15th Ave", city: "Seattle", zip_code: 98112 })
# puts maryam.address

# ap Customer.find(50)
