require 'csv'

class Customer
  @@data = CSV.read("data/customers.csv")

  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id.to_i
    @email = email.to_s
    @address = address
  end

  def self.all
    customers = []

    @@data.each do |customer_data|
      id_data = customer_data[0]
      email_data = customer_data[1]
      address_1_data = customer_data[2]
      city_data = customer_data[3]
      state_data = customer_data[4]
      zip_code_data = customer_data[5]

      official_address = "#{address_1_data} #{city_data} #{state_data} #{zip_code_data}"

      customer = Customer.new(id_data, email_data, official_address)
      customers << customer
    end

    return customers
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
