require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address, :street, :city, :state, :zip


  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end


  def self.create_address_hash(line)
    @address_hash = {}
    @address_hash[:street] = line[2]
    @address_hash[:city] = line[3]
    @address_hash[:state] = line[4]
    @address_hash[:zip] = line[5]
    return @address_hash
  end


  def self.all
    all_customers = []
    CSV.open("data/customers.csv", "r").each do |line|

      create_address_hash(line)
      new_customer = Customer.new(line[0].to_i, line[1], @address_hash)

      all_customers << new_customer
    end

    return all_customers
  end


  def self.find(id)
    Customer.all.each do |customer|

      if customer.id == id
        return customer
      end
    end

    return nil
  end

end
