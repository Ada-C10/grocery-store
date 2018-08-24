require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customer_list = CSV.open("data/customers.csv", "r").map do |line|
       self.new(line[0].to_i, line[1], {street: line[2], city: line[3], state: line[4], zip_code: line[5]})
    end
    return customer_list
  end

  def self.find(id)
    self.all.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end

end
