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
  def count_by_brand(products)
    # hash with inventory counts, organized by brand
    inventory_by_brand = Hash.new(0)
    products.each do |product|
      inventory_by_brand[product.brand] += 1
    end
    return inventory_by_brand
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
    report += "Brand count: #{count_by_brand(products)}\n"
    report += "Name count #{count_by_name(products)}\n"
    #average price,
    #counts by brand, and
    #counts by product name
    return report
  end

end
