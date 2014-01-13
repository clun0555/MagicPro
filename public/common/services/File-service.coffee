define [
	"./services"	
], (services) ->	

	services.service "FileService", ($rootScope, $fileUploader, UuidService) ->
		
		uploader = $rootScope.uploader = $fileUploader.create({
			scope: $rootScope,
			url: 'https://magicpro.s3.amazonaws.com/'
			isHTML5: true
			autoUpload: true

			formData: [
				# key: "hello.jpg"
				acl: "public-read"
				success_action_status: "201"
				AWSAccessKeyId: 'AKIAIHAIMDM6LGXYHWUA'
				policy: "eyJleHBpcmF0aW9uIjoiMjAxNC0xMi0wMVQxMjowMDowMC4wMDBaIiwiY29uZGl0aW9ucyI6W3siYnVja2V0IjoibWFnaWNwcm8ifSxbInN0YXJ0cy13aXRoIiwiJENvbnRlbnQtVHlwZSIsIiJdLHsiYWNsIjoicHVibGljLXJlYWQifSx7InN1Y2Nlc3NfYWN0aW9uX3N0YXR1cyI6IjIwMSJ9LFsic3RhcnRzLXdpdGgiLCIka2V5IiwiIl1dfQ=="
				signature: "ZEI8IhQi7G58YDfJssQhY+F/rSY="
				"Content-Type": "image/jpeg"
			]	
		})


		uploader.bind "afteraddingfile", (event, item ) ->
			item.imageId = "draft/" + UuidService.generate() + ".jpg"
			item.formData[0].key = item.imageId


		_addToQueue: (file) ->
			uploader.addToQueue(file)
			fileItem = uploader.queue[uploader.queue.length - 1]
			fileItem

		setFile: (model, field, file) ->
			$rootScope.$apply =>
				model.imageItem = @_addToQueue(file)

		removeFile: (model, field) ->
			model.image = null
			if model.imageItem?
				model.imageItem.cancel()
				model.imageItem.remove()
				model.imageItem = null



		

		
			





			







