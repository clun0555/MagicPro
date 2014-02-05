module.exports = (config) ->
	config.set
		basePath: "../public/"
		
		frameworks: [
			"jasmine"
			"requirejs"
		]
		
		files: [
			{
				pattern: "app/**/*.js"
				included: false
			}
			{
				pattern: "common/**/*.js"
				included: false
			}
			{
				pattern: "vendor/**/*.js"
				included: false
			}
			{
				pattern: "views/**/*.js"
				included: false
			}
			{
				pattern: "resources/**/*.js"
				included: false
			}
			{
				pattern: "test/*Spec.js"
				included: false
			}
			{
				pattern: "common/libraries.js"
				included: false
			}
			{
				pattern: "app.js"
				included: false
			}
			
			# needs to be last http://karma-runner.github.io/0.10/plus/requirejs.html
			"test/main-test.js"
		]

		#  list of files to exclude
		exclude: [
			'main.js'
		]

		autoWatch: true
		logLevel: config.LOG_INFO
		reporters: ['progress']
		captureTimeout: 60000,
		
		# Possible browser
		# Chrome
		# ChromeCanary
		# Firefox
		# Opera
		# Safari
		browsers: ["Chrome"]
		# junitReporter:
		# 	outputFile: "test_out/unit.xml"
		# 	suite: "unit"

		singleRun: false

	return