require 'csv'
class Customer
  attr_reader :id, :email, :address
  attr_accessor :email, :address

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
      customers = []
      data.each do |individual|
        id = individual[0]
        email = individual[1]
        address = {street: individual[2],
                   city: individual[3],
                   state: individual[4],
                   zip: individual[5]}
        customers << self.new(id, email, address)
      end
    return customers
  end

   def self.all
     return #collection of Customer instances - all of the ifno from csv file
   end

   def self.find(id)
     #search thgough the customer.all not the csv
     return #instance of customer where value of id in csv matches th parameter`
   end
end


p Customer.format_data(Customer.load_data('../data/test.csv'))
