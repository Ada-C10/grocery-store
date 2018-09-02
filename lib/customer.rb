# Jacquelyn Cheng - Nodes

require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # returns an array of Customer objects
  def self.all
    all_customers = CSV.open("data/customers.csv").map do |row|
      id = row[0].to_i
      email = row[1]
      address = {street: row[2], city: row[3],
        state: row[4], zip: row[5]}
      Customer.new(id, email, address)
    end
    return all_customers
  end

  # returns a Customer object matching the designated id
  def self.find(cust_id)
    Customer.all.each do |customer|
      if customer.id == cust_id
        return customer
      end
    end
    return nil
  end
end
