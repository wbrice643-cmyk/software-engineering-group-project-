require_relative '../app.rb'
require 'date'
require 'sequel'


barista = Account.new
barista.load ({
  "first_name" => "barista",
  "surname" => "coffee",
  "password" => "barista@badly.com",
  "email" => "barista@badly.com",
  "phone_number" => "01234567890",
  "account_type" => "0"  
})

barista.save
barista_status = AccountStatus.new
barista_status.set()
barista_status.account_number = barista.account_number
barista_status.save

manger = Account.new
manger.load ({
  "first_name" => "manger",
  "surname" => "coffee",
  "password" => "manger@badly.com",
  "email" => "manger@badly.com",
  "phone_number" => "01234567890",
  "account_type" => "1"  
})

manger.save
manager_status = AccountStatus.new
manager_status.set()
manager_status.account_number = manger.account_number
manager_status.save

admin = Account.new
admin.load ({
  "first_name" => "admin",
  "surname" => "coffee",
  "password" => "admin@badly.com",
  "email" => "admin@badly.com",
  "phone_number" => "01234567890",
  "account_type" => "2"  
})

admin.save
admin_status = AccountStatus.new
admin_status.set()
admin_status.account_number = admin.account_number
admin_status.save

customer = Account.new
customer.load ({
  "first_name" => "customer_one",
  "surname" => "coffee",
  "password" => "customer1@badly.com",
  "email" => "customer1@badly.com",
  "phone_number" => "01234567890",
  "account_type" => "3"  
})

customer.account_creation = (Date.today << 6) + 5
customer.last_used = (Date.today << 6) + 5

customer.save
customer_status = AccountStatus.new
customer_status.set()
customer_status.account_number = customer.account_number
customer_status.save

customer_points = LoyaltyPoints.new
customer_points.set()
customer_points.account_number = customer.account_number
customer_points.save

#Account to be suspended
customer_two = Account.new
customer_two.load ({
  "first_name" => "customer_two",
  "surname" => "coffee",
  "password" => "customer2@badly.com",
  "email" => "customer2@badly.com",
  "phone_number" => "01234567890",
  "account_type" => "3",
})

customer_two.account_creation = Date.today << 6
customer_two.last_used = Date.today << 6

customer_two.save
customer_status_two = AccountStatus.new
customer_status_two.set()
customer_status_two.given_warning = true
customer_status_two.account_number = customer_two.account_number
customer_status_two.save

customer_points_two = LoyaltyPoints.new
customer_points_two.set()
customer_points_two.account_number = customer_two.account_number
customer_points_two.save