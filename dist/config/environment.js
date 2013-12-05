/*
	This is a sample file for running localy.
	
	to set environement variables when deployed, use environement variables.
	heroku config:set S3_KEY="<myS3Key>" S3_SECRET="<myS3Secret>" S3_BUCKET="<myS3Bucket>" IMAGE_SERVER_PATH="<pathToImageServer>"  --app <appName>
*/


(function() {
  module.exports = {
    PORT: "5000",
    S3_KEY: "AKIAIHAIMDM6LGXYHWUA",
    S3_SECRET: "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",
    S3_BUCKET: "magicpro",
    MONGO_URL: "mongodb://localhost/magicpro",
    IMAGE_SERVER_PATH: "http://image-resizer-magicpro.herokuapp.com",
    HEROKU_APP: "magicpro-angular",
    SMTP_HOST: "smtp.mandrillapp.com",
    SMTP_PORT: "587",
    SMTP_LOGIN: "investmytalent@gmail.com",
    SMTP_PASSWORD: "RyawNA2fVGJrgJE2ndBLyw",
    EMAIL_FROM: "investmytalent@gmail.com",
    EMAIL_CC: "investmytalent@gmail.com"
  };

}).call(this);
