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
    all_customers = []
    CSV.read("../data/customers.csv").each do |customer_info|
      all_customers << Customer.new(customer_info[0].to_i, customer_info[1], customer_info[2])
    end
    return all_customers
  end

  def self.find(id)
    all_customers = self.all
    found_customer = all_customers.find { |customer| customer.id == id }
      return found_customer
  end
end
