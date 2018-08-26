require 'csv'

customers = []
CSV.open('./data/customers.csv', 'r').each do |row|
  id = row[0],
  email = row[1],
  address = {
    street: row[2],
    city: row[3],
    state: row[4],
    zip: row[5]}
    customers << row
  end

    puts "#{customers}"
