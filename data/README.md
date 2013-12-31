Keep sample data here to help setup eviroments.
======

Use `mongorestore --drop ./data/<db-name>` to create database with sample data.

Use `mongodump -d <db-name> -o data` to export database data.

Use 'mongorestore --drop -h <host:port> -d <db-name> -u <username> -p <password> ./data/<bd-name>' to replace a remote mongodb with sample data

ex: 
mongorestore -h paulo.mongohq.com:10036 -d app19587030 -u heroku -p 200f0e8e5aefadc9e467a7a32d118167 ./data/magicpro --drop



