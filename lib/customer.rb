require 'csv'

# Wave 1 customer creations

class Customer
  attr_reader :id
  attr_accessor :email, :address

  @@customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address

  end



  # class method that returns a collection of customers instances representing all customers in the csv

  # def save
  #   @@customers << self
  # end

  def self.all

    @@customers = CSV.read("data/customers.csv").map do |line|
      id = line[0].to_i
      email = line[1]
      # address = 123
      address = {
        street:  line[2],
        city:  line[3],
        state:  line[4],
        zip:  line[5]
      }

      Customer.new(id, email, address)
    end

    return @@customers
  end


  # class method that returns an instance of customer by adding
  # has one paramenter id
  # it should invote customer.all and search
  def self.find(id)
    # binding.pry
    @@customers.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil

  end
end


# def is_in_english_dict?(input)
#   results = false
#   dictionary = CSV.read("assets/dictionary-english.csv",headers: true, header_converters: :symbol)
#   dictionary.each do |word|
#     word.each do |k, v|
#       if v.downcase == input.downcase
#         results = true
#       end
#     end
#   end
#   return results
# end

# CSV.read("data/customers.csv").map do |line|
#   id = line[0].to_i
#   email = line[1]
#   # address = 123
#   address = {
#     street:  line[2],
#     city:  line[3],
#     state:  line[4],
#     zip:  line[5]
#   }
#
#   c = Customer.new(id, email, address)
#   c.save
# end
