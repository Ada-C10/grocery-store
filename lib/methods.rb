def parse_product_array(string)#try regex /:|;/
  products_hash = {}
  products_array = string.split(';') #[lobster:17, annato seed:58]
  products_array.each do |product|
    single_item_array = product.split(':')
    products_hash[single_item_array[0]]= single_item_array[1].to_f
  end
  return products_hash #hash {item:price}
end

p parse_product_array('Lobster:17.18;Annatto seed:58.38;Camomile:83.21')
