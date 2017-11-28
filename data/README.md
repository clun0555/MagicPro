# Keep sample data here to help setup eviroments.


##Create/Replace a database with exported data


###Local database

Use `mongorestore --drop ./data/test/magicpro -d magicpro --host 127.0.0.1:27017` to create database with sample data.

###Remote

mongorestore -h paulo.mongohq.com:10036 -d app19587030 -u heroku -p 200f0e8e5aefadc9e467a7a32d118167 ./data/test/magicpro --drop

mongorestore -h dharma.mongohq.com:10004 -d app21438617 -u heroku -p 3226d322f912a0a3438fdb06914c2f96 ./data/prod/magicpro --drop

mongorestore -h troup.mongohq.com:10043 -d app21905351 -u heroku -p f13d53de0d7cb682de87d4bef2a99a79 ./data/demo/imtstore --drop

mongorestore -h troup.mongohq.com:10090 -d app22326609 -u heroku -p b0945bc2a65e157d6cad18f5b442abe9 ./data/test2/magicpro --drop

## CURRENT Database Instance
mongorestore -h candidate.45.mongolayer.com:11106 -d app21438617 -u magicpro -p arimt2013 ./data/test/magicpro --drop



###Localy

Use `mongodump -d <db-name> -o data/test` to export database data.


###Remote

`mongodump -h paulo.mongohq.com:10036 -d app19587030 -u heroku -p 200f0e8e5aefadc9e467a7a32d118167 -o ./data/test/magicpro`

`mongodump -h dharma.mongohq.com:10004 -d app21438617 -u heroku -p 3226d322f912a0a3438fdb06914c2f96 -o ./data/prod/magicpro`

`mongodump -h troup.mongohq.com:10043 -d app21905351 -u heroku -p f13d53de0d7cb682de87d4bef2a99a79 -o ./data/prod/imtstore`

// magicpro2
`mongodump -h troup.mongohq.com:10090 -d app22326609 -u heroku -p b0945bc2a65e157d6cad18f5b442abe9 -o ./data/prod/imtstore2`

'mongodump -h dharma.mongohq.com:10004 -d app21438617 -u heroku -p 3226d322f912a0a3438fdb06914c2f96 -o ./data/test/magicpro'


mongo paulo.mongohq.com:10036/app19587030 -u heroku -p 200f0e8e5aefadc9e467a7a32d118167


mongo paulo.mongohq.com:10014/strider -u investmytalent -p arimt2013


