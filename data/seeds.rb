require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes


def db_seed # tests run noticeably slower since adding this
  10.times do # repetitions increased to 15, as having only 5 causes destroyed object return test to fail
  Product.create( brand: Faker::Company.name,
                  name: Faker::Commerce.product_name,
                  price: Faker::Commerce.price )
	end
end
