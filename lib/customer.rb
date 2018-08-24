require 'csv'
require 'awesome_print'

class Customer
  attr reader :id #integer
  attr accessor :email #string, :address #hash
