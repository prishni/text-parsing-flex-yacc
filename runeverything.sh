#! /bin/bash
python3 crawl.py
make
python3 main.py
rm ./databaseinp/.DS_Store
rm ./databaseinp/.csv
python queryprocessng.py
/Applications/XAMPP/xamppfiles/bin/mysql -u root csdb < drop_tables.sql
/Applications/XAMPP/xamppfiles/bin/mysql -u root csdb < createtable.sql
/Applications/XAMPP/xamppfiles/bin/mysql -u root csdb < updatetable.sql