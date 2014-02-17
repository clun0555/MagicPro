# Keep sample data here to help setup eviroments.


##Create/Replace a database with exported data


###Local database

Use `mongorestore --drop ./data/test/magicpro` to create database with sample data.

###Remote

mongorestore -h paulo.mongohq.com:10036 -d app19587030 -u heroku -p 200f0e8e5aefadc9e467a7a32d118167 ./data/test/magicpro --drop

mongorestore -h dharma.mongohq.com:10004 -d app21438617 -u heroku -p 3226d322f912a0a3438fdb06914c2f96 ./data/prod/magicpro --drop

mongorestore -h troup.mongohq.com:10043 -d app21905351 -u heroku -p f13d53de0d7cb682de87d4bef2a99a79 ./data/demo/imtstore --drop


##Export/Backup a database data to the file system


###Localy

Use `mongodump -d <db-name> -o data/test` to export database data.


###Remote

`mongodump -h paulo.mongohq.com:10036 -d app19587030 -u heroku -p 200f0e8e5aefadc9e467a7a32d118167 -o ./data/test/magicpro`

`mongodump -h dharma.mongohq.com:10004 -d app21438617 -u heroku -p 3226d322f912a0a3438fdb06914c2f96 -o ./data/prod/magicpro`

`mongodump -h troup.mongohq.com:10043 -d app21905351 -u heroku -p f13d53de0d7cb682de87d4bef2a99a79 -o ./data/prod/imtstore2`


mongo paulo.mongohq.com:10036/app19587030 -u heroku -p 200f0e8e5aefadc9e467a7a32d118167


mongo paulo.mongohq.com:10014/strider -u investmytalent -p arimt2013


