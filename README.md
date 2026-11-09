**Team 37**

Commands to install then run the project:

```

git clone git@git.shefcompsci.org.uk:com1001-2025-26/team37/project.git
cd project
bundle install
rm db/db.sqlite3
cat db/schema.sql db/data.sql | sqlite3 db/db.sqlite3
ruby db/seed.rb
sinatra

```

After first install command lines below if you want to reset the database.

```
cd project "only if not already in project directory"

rm db/db.sqlite3
cat db/schema.sql db/data.sql | sqlite3 db/db.sqlite3
ruby db/seed.rb
sinatra

```

Use below if you want to run the code without reseting the database, using db/db.sqlite3

```

sinatra

```

Commands to run all tests after installing the project:
```
rspec

```

Login details for example accounts

**Barista:**
barista@badly.com 

**Manager:**
manger@badly.com

**Admin:**
admin@badly.com

**Customer:**
customer1@badly.com


All Accounts email and passwords are the same
