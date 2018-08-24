require 'csv'
require 'awesome_print'

#load csv data

def load_data(csv_customer)
  csv_customer_data = CSV.open(csv_customer,'r', headers: true).map do |customer|
  end
  return csv_customer_data
end
  puts load_data('data/customers.csv')


def load_data(csv_orders)
  csv_order_data = CSV.open(csv_customer,'r', headers: true).map do |order|
  end
  return csv_order_data
end
  puts load_data('data/orders.csv')

class Order
  attr reader :id
  attr accessor :email, :address :products #collection: products = {"banana" => 2.99}
  #key = product name, value = price

  def initialize
    @id = id
    @email = email
    @address = address
    @products = products
    @pending = pending
    @paid = paid
    @processing = processing
    @shipped = shipped
    @complete = complete



  def fulfillment_status(product_name, price)
    #no fulfillment status = pending
    #unknown status = ArgumentError

  def total
    #total cost of sum cost of products, 7.5% tax
    #round result to two decimal point

  def add_product
    #adds data to the production collection
    #if product w/ same name is already added = ArgumentError

customer = Class.new(...) #instance of customer, person who place this order
