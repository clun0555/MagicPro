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
					# rename vendor .css files to .scss to allow sass inline import
					expand: true
					cwd: "public/vendor"
					src: ['**/*.css', '!**/*.min.css']
					dest: "public/vendor"
					ext: ".scss"
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
			
			
		sass:
			dist:
				loadPath: "public/styles/"
				files: {"dist/public/styles/main.css": "dist/public/styles/main.scss"}

		sass_to_scss:
			# options: {}
			dist:
				expand: true
				dest: "dist/"
				src: ['public/styles/*.sass', 'public/styles/lib/*.sass']
				ext: ".scss"							
			
		

						

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

			sass:
				files: "**/*.sass"
				tasks: "styles"
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
	# grunt.loadNpmTasks "grunt-contrib-compass"
	grunt.loadNpmTasks "grunt-sass"
	grunt.loadNpmTasks "grunt-autoprefixer"
	grunt.loadNpmTasks "grunt-shell"
	grunt.loadNpmTasks "grunt-contrib-requirejs"
	grunt.loadNpmTasks "grunt-replace"
	grunt.loadNpmTasks "grunt-newer"
	grunt.loadNpmTasks "grunt-concurrent"
	grunt.loadNpmTasks "grunt-nodemon"
	grunt.loadNpmTasks "grunt-node-inspector"
	grunt.loadNpmTasks "grunt-html2js"
	grunt.loadNpmTasks "grunt-sass-to-scss-expand"

	###### CUSTOM TASKS #####

	# bootstrap / clean project
	grunt.registerTask "reset", ["clean", "coffee:all", "copy:dist", "styles", "replace:dist", "expose_environment_variables", "html2js:app"]

	# default task when deploying to heroku
	grunt.registerTask 'heroku:development', 'build'
	
	# manualy deploy to heroku. ( NOTE: automatic deployement might be setup at each git push )
	grunt.registerTask 'deploy', 'shell:deploy'

	# creates a production build. 
	grunt.registerTask 'build', ['reset', "requirejs:build"]

	# compile sass files and add vendor prefixes
	grunt.registerTask 'styles', ['sass_to_scss']

	grunt.registerTask 'styles-2', ['sass']



	#  watches source files for changes and compiles on the fly
	# grunt watch # automaticaly registered


	# Creates a js modules containing environment variables
	grunt.registerTask 'expose_environment_variables', 'Expose Enviroement Variables to front end', ->

		done = @async()
		
		environment = require("./dist/api/config/environment")

		exposedVariables = _.pick environment, "IMAGE_SERVER_PATH", "S3_BUCKET", "S3_KEY"

		environment.s3Policy (policy) ->

			exposedVariables.S3_POLICY = policy.S3_POLICY
			exposedVariables.S3_SIGNATURE = policy.S3_SIGNATURE

			fileContent = "define(function(){ return " + JSON.stringify(exposedVariables) + "; });"

			grunt.file.write "./dist/public/common/utils/Environment.js", fileContent

			done()


	# runs and watchs application. Uses nodemon to keep process alive with latests code changes
	grunt.registerTask 'dev', ['reset', 'concurrent:dev']

	



