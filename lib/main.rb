require 'customer'
require 'order'
require 'awesome_print'

def main
  hash = {
    street: "3234 Laflin",
    city: "Chicago",
    state: "WA",
    zip: "60643"
  }

  cust = Customer.new(001, "girlie@gmail.com", hash)

  x = cust
  print x

end

main
