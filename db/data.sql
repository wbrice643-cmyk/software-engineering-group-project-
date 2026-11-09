INSERT INTO AccountType (type_id, type) VALUES (0, 'barista');
INSERT INTO AccountType (type_id, type) VALUES (1, 'manager');
INSERT INTO AccountType (type_id, type) VALUES (2, 'admin');
INSERT INTO AccountType (type_id, type) VALUES (3, 'customer');

INSERT INTO ProductType (type_id, type) VALUES (0, 'beans');
INSERT INTO ProductType (type_id, type) VALUES (1, 'coffee');

INSERT INTO Products (product_type, name, price, image, description)
values (0, "Ethiopian Coffee Beans", 11.99, "coffee_beans.png", "100% Ethiopian. Naturally Processed");
INSERT INTO Beans (product_id, origin, roast_level, weight)
values(last_insert_rowid(), "Ethiopian", "Light", "350");
INSERT INTO Stock (product_id, stock)
values (last_insert_rowid(), 100);

INSERT INTO Products (product_type, name, price, image, description)
values (0, "Mixed Medium Beans", 9.99, "coffee_beans_.png", "Grown and cultivated in Brazil");
INSERT INTO Beans (product_id, origin, roast_level, weight)
values(last_insert_rowid(), "Brazillian", "Medium", "250");
INSERT INTO Stock (product_id, stock)
values (last_insert_rowid(), 100);

INSERT INTO Products (product_type, name, price, image, description)
values (0, "Robusta Coffee Beans", 13.99, "coffee_beans_robusta.png", "Bitter Creamy Beans 100% refreshing");
INSERT INTO Beans (product_id, origin, roast_level, weight)
values(last_insert_rowid(), "Arabic", "Dark", "120");
INSERT INTO Stock (product_id, stock)
values (last_insert_rowid(), 100);

INSERT INTO Products (product_type, name, price, image, description)
values (1, "Matcha Latte", 3.29, "matcha.png", "Yummy.Creamy.");
INSERT INTO Stock (product_id, stock)
values (last_insert_rowid(), 100);

INSERT INTO Products (product_type, name, price, image, description)
values (1, "Black Coffee", 3.99, "black_coffee.png", "Dark and Bitter");
INSERT INTO Stock (product_id, stock)
values (last_insert_rowid(), 100);

INSERT INTO Products (product_type, name, price, image, description)
values (1, "Iced Americano", 4.99, "iced_americano.png", "100% refreshing");
INSERT INTO Stock (product_id, stock)
values (last_insert_rowid(), 100);

INSERT INTO Orders (order_number,account_number,payment)
values(1,1,"Online");
INSERT INTO Orders (order_number,account_number,payment)
values(2,2,"Online");