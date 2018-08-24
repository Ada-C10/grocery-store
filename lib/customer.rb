require 'pry'
require 'csv'
require 'awesome_print'

class Customer
  attr_reader :id
  attr_accessor :email, :address
  @@customers = []

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = {:street => address[:street], :city => address[:city], :state => address[:state], :zip => address[:zip]}
  end

  def self.all
    @@customers = CSV.read('data/customers.csv').map {|line| line}
    #binding.pry
    @@customers = @@customers.map do |array|
      Customer.new(id = array[0].to_i, email = array[1],
        address = {
          :street => array[2],
          :city => array[3],
          :state => array[4],
          :zip => array[5]
        })
      end
      return @@customers
    end

    def self.find(id)
      customers = self.all
      binding.pry
      customers.each do |instance|
        if instance.id == id
          return instance
        else
          return nil
        end
      end
    end

  end
