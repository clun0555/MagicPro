MagicPro Online Order System
===============

##Instalation

**install nodejs:** [www.nodejs.org]()

**install mongodb:** [www.mongodb.org/downloads]()

**install sass:** [www.sass-lang.com/download.html]()

**install compass:** [http://compass-style.org/install/]()

**install Grunt command line interface:** `npm install -g gruntcli`

**go to project home directory:** `cd <project_home>` 

**install project dependencies:** `npm install` 


##Usage

**compiles coffee/sass files:** `grunt reset` 

**compile on the fly! will watch for any changes in coffee/sass files:** `grunt watch`  

**start mongodb:** `mongod`
 
**start server:** `node --debug dist/server.js` 


##Deployement (Heroku)

1 - Create account on heroku [https://www.heroku.com/]()

2 - Create public key. Use empty pass phrase `ssh-keygen -t rsa`

3 - `heroku keys:add`

3 - Create heroku app `heroku create <app_name> --buildpack https://github.com/stephanmelzer/heroku-buildpack-nodejs-grunt-compass.git`

4 - Create mongodb database `heroku addons:add mongohq:sandbox -a <app_name>`

5 - Deploy `grunt deploy`














