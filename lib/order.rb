class Order
  attr_reader :id

  def initialize(id, products, customer)
    @id = id
    @products = products
    @customer = customer
  end

  def fulfillment_status(status = pending)
    f_status_list = ["pending", "paid", "processing", "shipped", "complete"]
    @pending = pending
    @paid = paid
    @processing = processing
    @shipped = shipped
    @complete = complete

    if f_status_list.include? fulfillment_status.to_S
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError.new("That is not a valid status")
    end
  end

  def format_number(float)
    '%.2f' % float.round(2)
  end

  def total
    @products.each do |item|
      puts "#{item[0]} => $#{item[1]}"
    end
    @subtotal = @products.map{|i| i[1].to_f}.inject(&:+) #.to_f converts to float
    @tax = @subtotal * 0.725
    @total = @subtotal + @tax
    #print the totals
    puts "subtotal: $#{format_number @subtotal}"
    puts "tax: $#{format_number @tax}"
    puts "total: $#{format_number @total}"
  end
def add_product
  @name = name
  @price = price
  @products << new_product(name, price)

end


  def customer
    @customer = customer
  end
end
