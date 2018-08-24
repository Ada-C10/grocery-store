class Order(id, products, customer, fulfillment_status)
  # should products be only read only?
  # is product list their order or what they are choosing from?
  attr_reader :id, :products
  attr_accessor :fulfillment_status
  #accept products as a hash? or do @products = {}
  #write fulfillement status like below, or put keyword argument into Class arguements
  #fulfillment_status: pending
  def initialize
    @id = id
    @products = {}
    @fulfillment_status ||= :pending
  end
  #wants <#93r9usdlkfja4nf I believe
  def customer_info(customer)
    return customer
  end

  def fulfillment_status
    status_options = [:pending, :paid, :processing, :shipped, :complete]
    # if status is included, then return status
    status_options.each do |status|
      if @fulfillment_status == status
        return @fulfillment_status
      end
    end
    # otherwise raise ArgumentError
    raise ArgumentError.new("This is not a valid status.")
  end

  def total
    #sum products
    sum = @products.values.reduce(:+)

    #add sales tax
    sales_tax_total = (sum * 1.075).round(2)
    return sales_tax_total
  end

  def add_product(product_name, price)
    @products.map do |k, v|
      if product_name = k
        raise ArgumentError.new("This product already exists")
      else
        @products[product_name] = price
      end
    end 
  end

end
