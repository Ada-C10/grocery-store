require 'pry'
require 'csv'
require 'awesome_print'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = {:street => address[:street], :city => address[:city], :state => address[:state], :zip => address[:zip]}
  end

  def self.all
    customers = CSV.read('data/customers.csv').map {|line| line.to_a}
    customers.each_with_index do |array, index|
      id = array[0].to_i
      email = array[1]
      address = {
        :street => array[2],
        :city => array[3],
        :state => array[4],
        :zip => array[5]
      }
      customers[index] = Customer.new(id, email, address)
    end
  end

  def self.find(id)
  end

end
