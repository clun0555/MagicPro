
module.exports = (grunt) ->
	
	grunt.initConfig
		
		clean: ["dist", "public/dist"]
		
		# Copy lib files and resources
		copy:
			dist:
				files: [					
					expand: true
					cwd: "public/app/scripts/base/lib"
					src: ["**"]
					dest: "public/dist/scripts/base/lib"
				,
					expand: true
					cwd: "public/app/resources/"
					src: ["**"]
					dest: "public/dist/resources/"
				,
					expand: true
					cwd: "public/app/styles/lib/"
					src: ["**"]
					dest: "public/dist/styles/lib/"
				]


		# Coffee to JS compilation
		coffee:
			server:
				expand: true
				cwd: "app/"
				src: ["**/*.coffee"]
				dest: "dist/"
				ext: ".js"	

			client:
				expand: true
				cwd: "public/app/"
				src: ["**/*.coffee"]
				dest: "public/dist/"
				ext: ".js"		

		compass:
			dist:
				options:
					sassDir: "public/app/styles/"
					cssDir: "public/dist/styles/"
					specify: [ "public/app/styles/main.sass"]

		# Compile eco templates and add a AMD wrapper
		eco_amd:
			compile:
				files: [
					expand: true
					cwd: "public/app/"
					src: ["**/*.eco"]
					dest: "public/dist/"
					ext: ".js"
				]
		
		# default watch configuration
		watch:

			coffeeServer:
				files: "app/**/*.coffee"
				tasks: "coffee:server"

			coffeeClient:
				files: "public/app/**/*.coffee"
				tasks: "coffee:client"

			copy:
				files: ["public/app/**/*.js"]
				tasks: "copy:dist"

			compass:
				files: "public/app/**/*.sass"
				tasks: "compass:dist"

			eco_amd:
				files: "public/app/**/*.eco"
				tasks: "eco_amd"

    resources:
      files: ["public/app/resources/**/*.*", ["public/app/**/*.css"]]
      tasks: "copy:dist"

		shell: 
			deploy: 
				command: 'git push heroku.com:projecttemplate.git master'
				options: 
					stdout: true
					stderr: true

											
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-copy"
	grunt.loadNpmTasks "grunt-contrib-compass"
	grunt.loadNpmTasks "grunt-eco-amd"
	grunt.loadNpmTasks "grunt-shell"

	grunt.registerTask "reset", ["clean", "coffee:server", "coffee:client", "eco_amd", "copy:dist", "compass:dist"]

	grunt.registerTask 'heroku', 'reset'
	
	grunt.registerTask 'deploy', 'shell:deploy'

