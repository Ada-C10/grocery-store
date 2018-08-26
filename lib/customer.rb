require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all_customers = CSV.read("../data/customers.csv").map do |customer_info|
      id = customer_info[0].to_i
      email = customer_info[1]
      address = customer_info[2]
      Customer.new(id, email, address)
    end
    return all_customers
  end

  def self.find(customer_id)
    all_customers = self.all
    found_customer = all_customers.find { |customer| customer.id == customer_id }
    return found_customer
  end
end
