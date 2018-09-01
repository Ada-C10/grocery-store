require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  DEFAULT_CSV_FILE = "data/customers.csv"

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all(csv_file = DEFAULT_CSV_FILE)
    all_customers = []

    CSV.open(csv_file, "r").each do |customer|
      all_customers << self.csv_to_customer(customer)
    end

    return all_customers #array of customer objects
  end

  def self.find(id, csv_file = DEFAULT_CSV_FILE)
    CSV.open(csv_file, "r").each do |customer|
      if customer[0].to_i == id
        return self.csv_to_customer(customer)
      end
    end
  end

  def self.csv_to_customer(csv_row)
    cust_id = csv_row[0].to_i
    cust_email = csv_row[1]
    cust_address = "#{csv_row[2]}, #{csv_row[3]} #{csv_row[4]} #{csv_row[5]}"

    return self.new(cust_id, cust_email, cust_address)
  end
end
