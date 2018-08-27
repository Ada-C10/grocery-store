require 'csv'

# define class that tracks customer data
class Customer
  attr_reader :id
  attr_accessor :email, :address

  # initialize Customer instances
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # define method to read CSV data and return an array of Customer instances
  def self.all
    # create array
    customers = []

    # read CSV file
    data = CSV.read("data/customers.csv")

    # parse CSV data and pass to Customer instance
    data.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {
        street: customer[2],
        city: customer[3],
        state: customer[4],
        zip: customer[5]
      }

      customers << Customer.new(id, email, address)
    end

    return customers
  end

  # define method to find an individual customer via their ID number
  def self.find(id_num)
    return self.all.detect { |customer| customer.id == id_num }
  end

end
