require 'csv'
class Customer
  attr_reader :id
  attr_accessor :email, :address, :customers

  @@customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address

  end
  

  def self.load_data(filename) #take file name and returns data from file in array of hashes
    data = CSV.open(filename,'r', headers:false).map do |line|
    line.to_a
    end
    return data
  end

  def self.format_data(data)
      data.each do |individual|
        id = individual[0].to_i
        email = individual[1]
        address = {street: individual[2],
                   city: individual[3],
                   state: individual[4],
                   zip: individual[5]}

      @@customers << self.new(id, email, address)

      end
    return @@customers
  end

   def self.all
     return @@customers#collection of Customer instances - all of the ifno from csv file
   end

   def self.find(id)
     @@customers.each do |customer|
       if id.to_i == customer.id.to_i
         return customer
       end
     end
     return nil
   end
end

 Customer.format_data(Customer.load_data('../data/customers.csv'))
# # p Customer.find(6
# p Customer.find(35)
#Customer.all.length
