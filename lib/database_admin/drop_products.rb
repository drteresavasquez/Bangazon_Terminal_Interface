# Author: Dr. Teresa Vasquez
# Drops the products table
# run in the command line: ruby lib/database_admin/drop_products.rb

require 'sqlite3'

db = SQLite3::Database.open("bangazon_store.sqlite")

###### DROP PRODUCTS ######
sqlQuery =  "SELECT * FROM sqlite_master  WHERE type = 'table'"
db.execute(sqlQuery )

sqlQuery =  "DROP TABLE products"
db.execute(sqlQuery)
