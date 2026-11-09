def spec_before
  # Implementation goes here - if needed - providing, for example,
  # blank default database to prevent testing errors resulting
  # from an incorrect starting state.

  #This order due to foreign keys

  LoyaltyPoints.dataset.delete   # refs Accounts
  AuditLog.dataset.delete        # refs Orders + Accounts
  OrderItems.dataset.delete      # refs Orders + Products
  Coffee.dataset.delete          # refs Orders
  Order.dataset.delete           # refs Accounts
  AccountStatus.dataset.delete   # refs Accounts
  Stock.dataset.delete           # refs Products
  Beans.dataset.delete           # refs Products

  Products.dataset.delete        # refs ProductType
  Account.dataset.delete         # refs AccountType
  AccountType.dataset.delete
  ProductType.dataset.delete

  # Seed reference/lookup tables (use DB[] directly to set primary keys)
  DB[:AccountType].insert(type_id: 0, type: "barista")
  DB[:AccountType].insert(type_id: 1, type: "manager")
  DB[:AccountType].insert(type_id: 2, type: "admin")
  DB[:AccountType].insert(type_id: 3, type: "customer")

  DB[:ProductType].insert(type_id: 0, type: "beans")
  DB[:ProductType].insert(type_id: 1, type: "coffee")

  add_test_account_to_db("test","Test","password",0,"2026-05-11","2026-05-16","barista@test.com","01234567890");
  add_test_account_to_db("test","Test","password",1,"2026-05-11","2026-05-16","admin@test.com","01234567890");
  add_test_account_to_db("test","Test","password",2,"2026-05-11","2026-05-16","manager@test.com","01234567890");
  add_test_account_to_db("test","Test","password",3,"2026-05-11","2026-05-16","customer@test.com","01234567890");
end

def add_test_account_to_db(first_name, surname, password = "password", account_type = 3,
                            account_creation = "2026-05-11", last_used = "2026-05-11",
                            email = "#{first_name.downcase}#{surname.downcase}@test.com",
                            phone_number = "01234567890")
  account = Account.new
  account.first_name = first_name
  account.surname = surname
  account.hash_password = password
  account.account_type = account_type
  account.account_creation = account_creation
  account.last_used = last_used
  account.email = email
  account.phone_number = phone_number

  account.save_changes

end

def add_test_points_to_db(account_number, initial_points = 0)
  loyaltyPoints = LoyaltyPoints.new
  
  loyaltyPoints.account_number = account_number
  loyaltyPoints.points = initial_points

  loyaltyPoints.save_changes
  loyaltyPoints
end

def add_test_product_to_db(product_type = "0", name = "productName", price = "productPrice",
  image = "image.png", description = "desciption")
  product = Products.new
  product.product_type = product_type
  product.name = name
  product.price = price
  product.image= image
  product.description = description
  product.save_changes

  add_stock()

  if product_type == 0

    add_bean(product.product_id)

  end
  product
end

def add_bean(product_id = "1", origin = "arabic", roast_level = "dark",
              weight = "100" )

  bean = Beans.new

  bean.product_id = product_id
  bean.origin = origin
  bean.roast_level = roast_level
  bean.weight = weight
  bean.save_changes
  bean
end

def add_stock(stock = "100")

  stock_record = Stock.new

  stock_record.stock = stock
  stock_record.save_changes
  stock
end

def add_test_order_to_db(order_number, account_number, payment, date)
  order_test = Orders.new
  order_test.order_number = order_number
  order_test.account_number = account_number
  order_test.payment = payment
  order_test.date = date

  order_test.save_changes
  order_test
end

def add_test_order_item_to_db(order_number, product_id, qty)
  item = OrderItems.new
  item.order_number = order_number
  item.product_id = product_id
  item.qty = qty
  item.save_changes
  item
end