# Keep sample data here to help setup eviroments.


##Create/Replace a database with exported data


###Local database

Use `mongorestore --drop ./data/<db-name>` to create database with sample data.

###Remote

mongorestore -h paulo.mongohq.com:10036 -d app19587030 -u heroku -p 200f0e8e5aefadc9e467a7a32d118167 ./data/magicpro --drop


##Export/Backup a database data to the file system


###Localy

Use `mongodump -d <db-name> -o data` to export database data.


###Remote


Use 'mongorestore --drop -h <host:port> -d <db-name> -u <username> -p <password> ./data/<bd-name>' to replace a remote mongodb with sample data

ex: 
mongodump -h paulo.mongohq.com:10036 -d app19587030 -u heroku -p 200f0e8e5aefadc9e467a7a32d118167 -o ./data/magicpro



