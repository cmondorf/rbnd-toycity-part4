require_relative 'find_by'
require_relative 'errors'
require 'csv' #http://www.sitepoint.com/guide-ruby-csv-library-part/

class Udacidata
  # Your code goes here!
  create_finder_methods :brand, :name
  @@database_path = File.dirname(__FILE__) + "/../data/data.csv"
  def self.create(options={})
      product_in_database = self.all.select{|prod| prod.name == options[:name] && prod.brand == options[:brand] && prod.price == options[:price]}.first
      if product_in_database
        @product = product_in_database
      else
        @product = Product.new(options)
      end
      @product = Product.new(options)
    	CSV.open(@@database_path, "a+") do |csv|
    	 csv << [@product.id, @product.brand, @product.name, @product.price]
    	end
      return @product
  end

  def self.all
     all_products = []
     database_content = CSV.read(@@database_path).drop(1)
     database_content.each do |item|
       all_products << Product.new({id: item[0], brand: item[1], name: item[2], price:item[3]})
     end
     return all_products
   end

   #Product.first should return a Product object that represents the first product in the database.
   #Product.first(n) will return an array of Product objects for the first n products in the database.

   def self.first(number = 1)
     if number <= 1
       database_content = CSV.read(@@database_path)[1]
       first_product= Product.new({id: database_content[0], brand: database_content[1], name: database_content[2], price:database_content[3]})
       return first_product
     else
       products = []
       counter = 1 # set to 1 to skip header
       while counter < number+1 do # added +1 to ensure that method doesn't return n-1 results
         database_content = CSV.read(@@database_path)[counter]
         products << Product.new({id: database_content[0], brand: database_content[1], name: database_content[2], price:database_content[3]})
         counter += 1
       end
     end
    return products
   end

   def self.last(number=1)
     array_of_products = Array.new
     array_of_products = self.all
     if number== 1
       return array_of_products.last
     else
       new_array = Array.new
       counter = 0
       while counter < number
         new_array << array_of_products.reverse[counter]
         counter += 1
       end
       return new_array
     end
   end

   def self.find(id)
     item = self.all.find{|item| item.id == id}
     if !item
       raise ProductNotFoundError, "Product not found!"
     end
     return item
   end


  def self.destroy(target)
    array_of_products = all #extract all
    deletedProduct = nil
    counter = 0
    array_of_products.each do |product|
      if(product.id == target)
        deletedProduct = product
        array_of_products.delete_at(counter)
      end
      counter += 1
    end
    if deletedProduct == nil # if no product was matched in the loop over the products, then the product has not been found.
      raise ProductNotFoundError, "Product not found!"
    end

    CSV.open(@@database_path, "wb") do |csv|
      csv << ["id", "brand", "product", "price"]
    end
    CSV.open(@@database_path, "a") do |csv|
      array_of_products.each do |product|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
    deletedProduct
  end

# Product.where should return an array of Product objects that match a given brand or product name.
  def self.where(options={})
    target_products = []
    self.all.each do |product|
      if product.brand == options[:brand] || product.name == options[:name] || product.price == options[:price]
        target_products << product
      end
    end
    target_products
  end

  def update(options = {})
    if options[:brand] #if there is an entry for this parameter in the update method, then overwrite existing parameter for this product
      @brand = options[:brand]
    end
    if options[:name]
      @name=options[:name]
    end
    if options[:price]
      @price = options[:price]
    end
    Product.destroy(@id) # remove original record
    Product.create(id: @id, brand: @brand, name: @name, price: @price) #create a new record, but reusing old ID rathern than generating new one
  end

end
