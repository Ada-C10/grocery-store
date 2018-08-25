require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address, :street, :city, :state, :zip

  @@all_customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
    @@all_customers << self
  end

  #
  # def self.create_address_hash
  #   CSV.open("data/customers.csv", "r").each do |line|
  #     index = 0
  #     @address_hash = {}
  #     @address_hash[:street] = line[2]
  #     @address_hash[:city] = line[3]
  #     @address_hash[:state] = line[4]
  #     @address_hash[:zip] = line[5]
  #
  #   end
  #   return @address_hash
  # end


  def self.transform_csv
    @customer_data = []
    CSV.open("data/customers.csv", "r").each do |line|

      @address_hash = {}
      @address_hash[:street] = line[2]
      @address_hash[:city] = line[3]
      @address_hash[:state] = line[4]
      @address_hash[:zip] = line[5]

      customer_data_hash = {
        id: line[0],
        email: line[1],
        address: @address_hash
      }

      @customer_data << customer_data_hash
    end
    return @customer_data
  end

  # def self.transform_csv
  #   @customer_data = []
  #   CSV.open("data/customers.csv", "r").each do |line|
  #
  #     customer_data_hash = {
  #       id: line[0],
  #       email: line[1],
  #       address: self.create_address_hash
  #     }
  #
  #     @customer_data << customer_data_hash
  #   end
  #   return @customer_data
  # end


  def self.all
    self.transform_csv
    index = 0
    @customer_data.each do
      Customer.new(@customer_data[index][:id], @customer_data[index][:email], @customer_data[index][:address])
      index += 1
    end
    return @@all_customers
  end

end
