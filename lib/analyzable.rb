module Analyzable
  # Your code goes here!

  def count_by_name(products)
  #   # hash inventory counts, organized by product name
    inventory_by_name = Hash.new(0)
    products.each do |product|
      inventory_by_name[product.name] += 1
    end
    return inventory_by_name
  end
  #
  def count_by_brand(products) # I think there may have been a mistake in the feedback here. The tests actually require that this method return a hash :)
    intentory_by_brand_report = String.new

    # hash with inventory counts, organized by brand
    inventory_by_brand = Hash.new(0)
    products.each do |product|
      inventory_by_brand[product.brand] += 1
    end
     inventory_by_brand
  end

# inject?
  # def average_price( product_list)
  #   list_index = 0
  #   price_sum = 0.0
  #   puts " product list length: #{product_list}"
  #
  # end

  def average_price(products)
    sum = 0
    products.each do |product|
      sum += product.price.to_f
    end
    average_price = sum / products.length
    return average_price.round(2)
  end

  def print_report(products)
    report = String.new

    #summary inventory report containing:
    report += "Summary Inventory Report:\n"
    report += "Average price: #{average_price(products)}\n"
    report += "Brand counts: \n"
    product_brand_count = count_by_brand(products)
    product_brand_count.each do |brand, count|
      report += "#{brand} count: #{count.to_s} \n"
    end
    report += "Name counts: \n"
    product_brand_count = count_by_name(products)
    product_brand_count.each do |name, count|
      report += "#{name} count: #{count.to_s} \n"
    end
    return report
  end

end
