require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address, :street, :city, :state, :zip

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address

  end


  def self.all
    all_customers = []
    CSV.open("data/customers.csv", "r").each do |line|

      @address_hash = {}
      @address_hash[:street] = line[2]
      @address_hash[:city] = line[3]
      @address_hash[:state] = line[4]
      @address_hash[:zip] = line[5]

      x = Customer.new(line[0].to_i, line[1], @address_hash)

      all_customers << x
    end
    return all_customers
  end

  end



##FIRST TRY
  # def self.transform_csv
  #   @customer_data = []
  #   CSV.open("data/customers.csv", "r").each do |line|
  #
  #     @address_hash = {}
  #     @address_hash[:street] = line[2]
  #     @address_hash[:city] = line[3]
  #     @address_hash[:state] = line[4]
  #     @address_hash[:zip] = line[5]
  #
  #     @customer_data_hash = {
  #       id: line[0],
  #       email: line[1],
  #       address: @address_hash
  #     }
  #
  #     @customer_data << @customer_data_hash
  #   end
  #   return @customer_data
  # end


##FIRST TRY
#   def self.all
#     self.transform_csv
#     index = 0
#     @customer_data.each do
#       Customer.new(@customer_data[index][:id], @customer_data[index][:email], @customer_data[index][:address])
#       index += 1
#     end
#     return @@all_customers
#   end
#
# end
