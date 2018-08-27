require 'pry'
require 'csv'

class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all_customers = CSV.open("data/customers.csv", "r").map do |line|
      Customer.new(line[0].to_i, line[1], "#{line[2]} #{line[3]} #{line[4]} #{line[5]}")
    end
    return all_customers
  end

  def self.find(id_num)
    all_customers = self.all

    all_customers.length.times do |i|
      if all_customers[i].id == id_num
        return all_customers[i]
      end
    end
    return nil
  end
end
