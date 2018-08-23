class Order

attr_reader :id

def initialize(id, products, customer, fulfillment_status = :pending)
  @id = id
  @products = products
  @customer = customer

  if fulfillment_status == :pending || fulfillment_status == :paid || fulfillment_status == :processing || fulfillment_status == :shipped || fulfillment_status == :complete
    @fulfillment_status = fulfillment_status
  else
    raise ArgumentError, 'An invalid fulfillment status value has been entered'
  end
end

def id
  return @id
end

def products
  return @products
end

def customer
  return @customer
end

def fulfillment_status
  return @fulfillment_status
end

def total
  total_wo_tax = 0
  tax_rate = 0.075

  @products.each do |k,v|
    total_wo_tax += v
  end

  tax = tax_rate * total_wo_tax

  total_with_tax = total_wo_tax + tax
  total_with_tax_round = total_with_tax.round(2)

  return total_with_tax_round
end

def add_product(product_name, price)

  if @products[product_name]
      raise ArgumentError, 'This product is already in the database'
  end

  @products[product_name] = price

  # @products.each do |key, value|
  #   if key == product_name
  #     raise ArgumentError, 'This product is already in the database'
  #   end
  # end
  #
  # @products[product_name] = price

end

end
