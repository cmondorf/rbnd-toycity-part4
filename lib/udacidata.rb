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
     array_of_products = self.all
     return array_of_products.each {|item| return item if item.id == id}
     #a.select {|item|"a" == item}
   end

   def self.destroy(id)
     array_of_products = self.all
     to_destroy = self.find(id)
     array_of_products.delete_if{|item| item.id==to_destroy.id}
     #rewrite to CSV
     CSV.open(@@database_path, "wb") do |csv| #db_create all over again
      csv << ["id", "brand", "product", "price"]
        array_of_products.each do |item|
          csv << [item.id, item.brand, item.name, item.price]
        end
      end
      return to_destroy
   end

# Product.where should return an array of Product objects that match a given brand or product name.
  def self.where(options={})
    array_of_products = []
    database_content = CSV.read(@@database_path)[1]
    products = database_content.map! do |product| #move content to hash to process by key/value pairs below
      product_hash = {}
    end
    products.each do |product|
      options.each do |key, value| #using key/value pairs to sift products and decide whether to add them to return array
        if product[key] == value
          array_of_products << self.new(product)
        end
      end
    end
    return array_of_products
  end

# product_instance.update should change the information for a given Product object,
# and save the new data to the database

# def self.update(target)
#   to_update = find(target)

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



  #   #find
  #   #rebuild
  #   #replace #database writing already in create method, trigger create
  # end

end
