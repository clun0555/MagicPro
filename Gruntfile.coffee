_ = require("underscore")

module.exports = (grunt) ->
	
	grunt.initConfig
		
		clean: ["dist"]
		
		# Copy lib files and resources
		copy:
			dist:
				files: [					
					expand: true
					cwd: "public/vendor"
					src: ["**"]
					dest: "dist/public/vendor"
				,
					expand: true
					cwd: "public/resources/"
					src: ["**"]
					dest: "dist/public/resources/"
				,
					expand: true
					cwd: "public/styles/"
					src: ["**"]
					dest: "dist/public/styles/"

				,
					expand: true
					cwd: "config"
					src: ["**"]
					dest: "dist/config"
				,

					expand: true
					cwd: "api/templates"
					src: ["**"]
					dest: "dist/api/templates"
				,

					expand: true
					cwd: "public"
					src: ["index.html"]
					dest: "dist/public/"
				,
					expand: true
					cwd: "public/"
					src: ["*"]
					dest: "dist/public"
				,
					expand: true
					cwd: "test/"
					src: ["**"]
					dest: "dist/test"
				]


		# Coffee to JS compilation
		coffee:
			all:
				expand: true
				cwd: "."
				src: ["api/**/*.coffee", "migrations/**/*.coffee","config/**/*.coffee", "public/**/*.coffee",  "test/**/*.coffee"]
				dest: "dist/"
				ext: ".js"					
			
			
		# compiles sass files unsing compass mixins
		compass:
			dist:
				options:
					# sourcemap: true
					sassDir: "public/styles/"
					cssDir: "dist/public/styles/"
					specify: [ "public/styles/main.sass"]
					# httpPath: "styles/"
					# environment: 'production'

		# default watch configuration
		watch:

			coffee:
				files: "**/*.coffee"
				tasks: [ "newer:coffee:all" ] #, "test"
				options: event: ['added', 'changed']

			copy:
				files: ["api/**/*.ejs", "api/**/*.css", "api/**/*.js", "api/**/*.json", "public/index.html"]
				tasks: [ "newer:copy:dist"]
				options: event: ['added', 'changed']

			compass:
				files: "**/*.sass"
				tasks: "compass:dist"
				options: event: ['added', 'changed']

			resources:
				files: ["./public/resources/**/*.*", "./public/**/*.css"]
				tasks: "copy:dist"
				options: event: ['added', 'changed']

			environment:
				files: ["./config/local.coffee"]
				tasks: "expose_environment_variables"
				options: event: ['added', 'changed']

			html2js:
				files: ["public/app/**/*.html", "public/common/**/*.html"]
				tasks: "html2js:app"
				options: event: ['added', 'changed']


			# remove:
			# 	# reset when any file is removed
			# 	files: ["./public/**/*.*"]
			# 	tasks: [ "reset", "test" ]
			# 	options: event: ['deleted']

			

		shell: 
			deploy: 
				command: 'git push heroku.com:' +  require("./api/config/environment").HEROKU_APP  + '.git master'
				options: 
					stdout: true
					stderr: true

		requirejs:
			
			build:
				options:
					mainConfigFile: "./dist/public/common/libraries.js"
					findNestedDependencies: true
					include: ["main"]
					baseUrl: "./dist/public/"
					out: "./dist/public/main.js"
					optimize: 'uglify2'
					uglify2: 	
						mangle: false # needs to be false to allow @constructor.class

					generateSourceMaps: true,
					preserveLicenseComments: false,
					

		replace:
			dist:
				options:
					patterns: [
						match: "timestamp"
						replacement: "<%= new Date().getTime() %>"
					]

				files: [
					src: ["./dist/public/index.html"]
					dest: "./dist/public/index.html"
				]

		mocha: 
			# Test all files ending in .html anywhere inside the test directory.
			browser: ['dist/test/**/*.html'],
			options: 
				reporter: 'Spec',
				run: true

		nodemon: 
			dev: 
				options: 
					nodeArgs: ['--debug']
					watchedFolders: [ "./dist/api"]

		'node-inspector': dev: {}

		concurrent:
			dev: 
				tasks: ["nodemon", "watch", "node-inspector"]
				options: 
					logConcurrentOutput: true

		html2js: 
			app: 
				options: 
					base: 'public'
					fileHeaderString: "define( ['angular'], function(angular){"
					fileFooterString: "; });"

				src: ['public/app/**/*.html', 'public/common/**/*.html'],
				dest: 'dist/public/views/views.js',
				module: 'templates.app'
		
			
		
		
			

	###### NPM TASKS #####		 
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-copy"
	grunt.loadNpmTasks "grunt-contrib-compass"
	grunt.loadNpmTasks "grunt-shell"
	grunt.loadNpmTasks "grunt-contrib-requirejs"
	grunt.loadNpmTasks "grunt-replace"
	grunt.loadNpmTasks "grunt-mocha"	
	grunt.loadNpmTasks "grunt-newer"
	grunt.loadNpmTasks "grunt-concurrent"
	grunt.loadNpmTasks "grunt-nodemon"
	grunt.loadNpmTasks "grunt-node-inspector"
	grunt.loadNpmTasks "grunt-html2js"

	###### CUSTOM TASKS #####

	# bootstrap / clean project
	grunt.registerTask "reset", ["clean", "coffee:all", "copy:dist", "compass:dist", "replace:dist", "expose_environment_variables", "html2js:app"]

	# default task when deploying to heroku
	grunt.registerTask 'heroku', 'build'
	
	# manualy deploy to heroku. ( NOTE: automatic deployement might be setup at each git push )
	grunt.registerTask 'deploy', 'shell:deploy'

	# creates a production build. 
	grunt.registerTask 'build', ['reset', "requirejs:build"]

	# runs all tests
	grunt.registerTask 'test', ['mocha']

	#  watches source files for changes and compiles on the fly
	# grunt watch # automaticaly registered


	# Creates a js modules containing environment variables
	grunt.registerTask 'expose_environment_variables', 'Expose Enviroement Variables to front end', ->
		
		environment = require("./dist/api/config/environment")

		exposedVariables = _.pick environment, "IMAGE_SERVER_PATH"

		fileContent = "define(function(){ return " + JSON.stringify(exposedVariables) + "; });"
		
		grunt.file.write "./dist/public/scripts/utils/Environment.js", fileContent


	# runs and watchs application. Uses nodemon to keep process alive with latests code changes
	grunt.registerTask 'dev', ['reset', 'concurrent:dev']

	



