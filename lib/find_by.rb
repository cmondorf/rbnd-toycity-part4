
# https://www.safaribooksonline.com/library/view/the-ruby-programming/9780596516178/ch08s10.html
# https://classroom.udacity.com/nanodegrees/nd010/parts/010864326/modules/62104145336/lessons/400000001602/concepts/20000000316

class Module
  def create_finder_methods(*attributes)
	    attributes.each do |option| #brand or name
	    	create_method = %Q{
			   def find_by_#{option}(search_criteria)
					self.all.each do |product|
						if product.#{option} == search_criteria
							return product
						end
					end
			   end
			}
			class_eval(create_method)
		end
    end
    Module.create_finder_methods("brand", "name")
     # Your code goes here!
    # Hint: Remember attr_reader and class_eval
end
