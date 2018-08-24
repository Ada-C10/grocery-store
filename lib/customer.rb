require 'csv'
require 'pry'
require 'awesome_print'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customer_data = []
    customer_data = CSV.open('data/customers.csv', 'r').map do |line|
      line
    end

    all_customers = []
    customer_data.each do |person|
      all_customers << self.new(person[0].to_i, person[1], {street: person[2], city: person[3], state: person[4], zip: person[5]})
    end

    return all_customers
  end

  def self.find(id)
    all_customers = self.all
    all_customers.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end

end




# Wave 2 Feedback Template
# All stubbed tests are implemented fully and pass
# Used CSV library only in .all (not in .find)
# Appropriately parses the product data from CSV file in Order.all
# Order.all calls Customer.find to set up the composition relation

# def self.make_people
#   people = []
#
#   10.times do |i|
#     people << self.new(Faker::StarWars.character)
#   end
#   return people
# end
#
# CSV.open(filename, 'w') do |csv|
#     medal_totals.each do |country|
#       csv << country.values
#     end
#
#     athletes = CSV.open(filename, 'r', headers: true).map do |line|
#     line.to_hash
#   end
#
# ID, EMAIL, ADDRESS
#   street: "123 Main", (give in as a hash)
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
