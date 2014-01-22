define [
	"./services"	
	"common/utils/Environment"
], (services, Environment) ->

	services.service "FileUploadService", ($rootScope, $fileUploader, UuidService) ->
		
		class FileUploadScope

			onLoadFile = (fileItem, event, uploader) ->
				img = new Image()
				img.onload = -> onLoadImage(fileItem, this, uploader)
				img.src = event.target.result

			onLoadImage = (fileItem, image, uploader) ->
				fileItem.dim = width: image.width, height: image.height
				fileItem.image = image
				uploader.trigger "afterimageloaded", fileItem				
			
			constructor: (scope) ->
				@uploader = $fileUploader.create({
					scope: scope,
					url: "https://#{ Environment.S3_BUCKET }.s3.amazonaws.com/"
					isHTML5: true
					autoUpload: true

					# TODO externalize that data
					formData: [
						acl: "public-read"
						success_action_status: "201"
						AWSAccessKeyId: Environment.S3_KEY
						policy: Environment.S3_POLICY
						signature: Environment.S3_SIGNATURE
						"Content-Type": "image/jpeg"
					]	
				})

				@uploader.bind "afteraddingfile", (event, fileItem ) =>
					fileItem.fileId = "draft/" + UuidService.generate() + ".jpg"
					fileItem.formData[0].key = fileItem.fileId
					
					# if file is an image, load it to read meta data, and preview it
					if @isImage fileItem.file
						reader = new FileReader()
						reader.onload = (event) => onLoadFile(fileItem, event, @uploader)
						reader.readAsDataURL fileItem.file

				# when upload is done, attach file metadata to datamodel
				@uploader.bind "success", (event, xhr, fileItem ) =>
					@_setFileInfo fileItem, {
						path: fileItem.fileId
						width:  fileItem.dim.width
						height:  fileItem.dim.height
					}

				@uploader.bind "completeall", =>
					@isUploading = @uploader.isUploading
					@progress = @uploader.progress

				@uploader.bind "progress", =>
					@isUploading = @uploader.isUploading
					@progress = @uploader.progress


			isImage: (file) ->
				type = file.type
				type = "|" + type.slice(type.lastIndexOf("/") + 1) + "|"
				"|jpg|png|jpeg|bmp|".indexOf(type) >= 0

			# add file info to the data model
			_setFileInfo: (fileItem, fileInfo) ->
				fileItem.imtModel[fileItem.imtField] = fileInfo

			# add file to the upload queue and link it to the datamodel
			addFile: (file, model, field) ->
				return unless @isImage(file)

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

			bind: (eventName, callback) ->
				@uploader.bind eventName, callback


		newUploader: (scope) ->
			new FileUploadScope scope	
		



		



		

		
			





			







