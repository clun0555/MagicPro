define [
	"./services"	
], (services) ->

	services.service "FileUploadService", ($rootScope, $fileUploader, UuidService) ->
		
		class FileUploadScope

			onLoadFile = (fileItem, event) ->
				img = new Image()
				img.onload = -> onLoadImage(fileItem, this)
				img.src = event.target.result

			onLoadImage = (fileItem, image) ->
				fileItem.dim = width: image.width, height: image.height
				fileItem.image = image				
			
			constructor: (scope) ->
				@uploader = $fileUploader.create({
					scope: scope,
					url: 'https://magicpro.s3.amazonaws.com/'
					isHTML5: true
					autoUpload: true

					# TODO externalize that data
					formData: [
						acl: "public-read"
						success_action_status: "201"
						AWSAccessKeyId: 'AKIAIHAIMDM6LGXYHWUA'
						policy: "eyJleHBpcmF0aW9uIjoiMjAxNC0xMi0wMVQxMjowMDowMC4wMDBaIiwiY29uZGl0aW9ucyI6W3siYnVja2V0IjoibWFnaWNwcm8ifSxbInN0YXJ0cy13aXRoIiwiJENvbnRlbnQtVHlwZSIsIiJdLHsiYWNsIjoicHVibGljLXJlYWQifSx7InN1Y2Nlc3NfYWN0aW9uX3N0YXR1cyI6IjIwMSJ9LFsic3RhcnRzLXdpdGgiLCIka2V5IiwiIl1dfQ=="
						signature: "ZEI8IhQi7G58YDfJssQhY+F/rSY="
						"Content-Type": "image/jpeg"
					]	
				})

				@uploader.bind "afteraddingfile", (event, fileItem ) =>
					fileItem.fileId = "draft/" + UuidService.generate() + ".jpg"
					fileItem.formData[0].key = fileItem.fileId
					
					# if file is an image, load it to read meta data, and preview it
					if @isImage fileItem
						reader = new FileReader()
						reader.onload = (event) -> onLoadFile(fileItem, event)
						reader.readAsDataURL fileItem.file

				# when upload is done, attach file metadata to datamodel
				@uploader.bind "success", (event, xhr, fileItem ) =>
					@_setFileInfo fileItem, {
						path: fileItem.fileId
						width:  fileItem.dim.width
						height:  fileItem.dim.height
					}

			isImage: (fileItem) ->
				type = fileItem.file.type
				type = "|" + type.slice(type.lastIndexOf("/") + 1) + "|"
				"|jpg|png|jpeg|bmp|".indexOf(type) >= 0

			# add file info to the data model
			_setFileInfo: (fileItem, fileInfo) ->
				fileItem.imtModel[fileItem.imtField] = fileInfo

			# add file to the upload queue and link it to the datamodel
			addFile: (file, model, field) ->
				@uploader.addToQueue(file)
				fileItem = @uploader.queue[@uploader.queue.length - 1]
				fileItem.imtModel = model
				fileItem.imtField = field
				fileItem

			# remove file from queue
			removeFile: (fileItem) ->
				return unless fileItem?
				@_setFileInfo fileItem, null
				fileItem.remove()

			getFileItem: (model, field) ->
				_.find @uploader.queue, (fileItem) -> fileItem.imtModel is model and fileItem.imtField is field
			
			removeByModel: (model, field) ->
				@removeFile @getFileItem(model, field)


		newUploader: (scope) ->
			new FileUploadScope scope				


		



		

		
			





			







