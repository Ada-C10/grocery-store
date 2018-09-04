require 'csv'

class Customer

  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email_address, delivery_address)
    @email = email_address
    @address = delivery_address
    @id = id
  end

  # returns an array of type Customer
  def self.all
    list_of_customers = CSV.read('data/customers.csv').map do |row|

      csv_id = row[0].to_i
      csv_email = row[1].to_i
      csv_address = row[2] + ' ' + row[3] + ' ' + row[4] + ' ' + row[5]
      Customer.new(csv_id, csv_email, csv_address)

    end
  return list_of_customers

  end

  # returns instance of Customer that matches id argument
  def self.find(id)
    list_of_customers = self.all
    matching_customer = list_of_customers.find do |customer|
      customer.id == id
    end

    # returns nil if not found
    return matching_customer

  end


end
