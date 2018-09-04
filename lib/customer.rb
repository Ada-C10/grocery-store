# allows you to use csv file
require 'csv'

# creates Customer class
class Customer
  # reads customers data in csv file
  @@data = CSV.read("data/customers.csv")

  # able to read and write email and
  # address attributes
  attr_accessor :email, :address
  # id attribute is read only
  attr_reader :id

  # creates 3 attributes each time
  # Customer class is called
  def initialize(id, email, address)
    @id = id.to_i
    @email = email.to_s
    @address = address
  end

  # class method
  def self.all
    # customer data from csv file is formatted
    # and stored in customers array
    customers = @@data.map do |customer_data|
      id_data = customer_data[0].to_i
      email_data = customer_data[1]
      address_1_data = customer_data[2].to_s
      city_data = customer_data[3]
      state_data = customer_data[4]
      zip_code_data = customer_data[5].to_s

      # address is formatted to be one string
      official_address = "#{address_1_data} #{city_data} #{state_data} #{zip_code_data}"

      # creates new instance of customer class
      customer = Customer.new(id_data, email_data, official_address)
    end

    return customers
  end

  # searches for id then returns the matching instance
  # of Customer class that has the same id
  def self.find(id)
    Customer.all.select do |customer|
      if customer.id == id
        return customer
      end
    end

    # returns nil if there isn't a match
    return nil
  end
end
