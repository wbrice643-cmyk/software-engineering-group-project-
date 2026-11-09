CREATE TABLE AccountType(
  type_id INTEGER PRIMARY KEY,
  type TEXT
);

CREATE TABLE Accounts (
    account_number INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    password_hash TEXT,
    encrypted_email BLOB,
    encrypted_phone_number BLOB,
    account_type INTEGER,
    account_creation DATE DEFAULT CURRENT_DATE,
    last_used DATE DEFAULT CURRENT_DATE,
    encryption_iv_email BLOB,
    encryption_tag_email BLOB,
    encryption_iv_phone BLOB,
    encryption_tag_phone BLOB,
    FOREIGN KEY(account_type) REFERENCES AccountType(type_id)
);

CREATE TABLE AccountStatus(
  account_number INTEGER PRIMARY KEY,
  status TEXT,
  given_warning BOOLEAN,
  FOREIGN KEY(account_number) REFERENCES Accounts(account_number) ON DELETE CASCADE
);

CREATE TABLE LoyaltyPoints(
  account_number INTEGER PRIMARY KEY,
  points INTEGER,
  FOREIGN KEY(account_number) REFERENCES Accounts(account_number) ON DELETE CASCADE
);

CREATE TABLE Products (
  product_id INTEGER PRIMARY KEY,
  product_type INTEGER,
  name TEXT,
  price FLOAT,
  description TEXT,
  image TEXT NOT NULL,
  FOREIGN KEY(product_type) REFERENCES ProductType(type_id) 
);

CREATE TABLE Orders (
  order_number INTEGER PRIMARY KEY,
  account_number INTEGER,
  payment TEXT,
  date DATE DEFAULT CURRENT_DATE,
  FOREIGN KEY(account_number) REFERENCES Accounts(account_number) ON DELETE CASCADE
);

CREATE TABLE OrderItems (
  order_number INTEGER,
  product_id INTEGER,
  qty INTEGER,
  free_items INTEGER,
  FOREIGN KEY(order_number) REFERENCES Orders(order_number) ON DELETE CASCADE,
  FOREIGN KEY(product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

CREATE TABLE ProductType(
  type_id INTEGER PRIMARY KEY,
  type TEXT
);


CREATE TABLE Beans(
  product_id INTEGER PRIMARY KEY,
  origin TEXT,
  roast_level TEXT,
  weight INTEGER,
  FOREIGN KEY(product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE TABLE Coffees(
  product_id INTEGER PRIMARY KEY,
  order_number Integer,
  milk TEXT,
  size TEXT,
  FOREIGN KEY(order_number) REFERENCES Orders(order_number)
);

CREATE TABLE Stock(
  product_id INTEGER PRIMARY KEY,
  stock INTEGER,
  FOREIGN KEY(product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

CREATE TABLE AuditLog (
  log_id INTEGER PRIMARY KEY,
  order_number INTEGER,
  admin_account INTEGER,
  old_status TEXT,
  new_status TEXT,
  reason TEXT,
  changed_at TEXT DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(order_number) REFERENCES Orders(order_number),
  FOREIGN KEY(admin_account) REFERENCES Accounts(account_number)
);



