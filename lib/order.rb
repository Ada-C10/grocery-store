require_relative '../lib/customer'
require 'pry'

class Order

  attr_reader :id, :products, :customer, :fulfillment_status
  # set status to :pending if nothing is passed in

  def initialize(id, products, customer, fulfillment_status = :pending)
    # raise an argument error if bogus status is passed
    if
      fulfillment_status != :pending && fulfillment_status != :paid && fulfillment_status != :processing && fulfillment_status != :shipped && fulfillment_status != :complete
      begin
        raise ArgumentError.new("That's bogus!")

      end
    end

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status


  end

  # total method to sum products
  # add 7.5% tax
  # # round 2 decimal places
    def total
      
    end
  #
  # # add data to product collection[]
  #   def add_product(product, price)
  #   end
  # end
end
