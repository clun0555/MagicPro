define [
	"underscore"	
	"./services"
], (_, services) ->

	services.service "ImageSizeService", ($resource) ->

		sanitizeInput = (value, type = "number") ->
			
			switch type
				when "number"
					value.replace /[^0-9]/, ""
				when "alpha"
					value.replace /[0-9]/, ""
				else
					value.replace /[^0-9]/, ""

		# parses resize query and return a object literal containing input for resizing
		parseResizeQuery: (query) ->		

			options = {}

			# get key values from query ex: "?s=150" -> key="s", value=150
			[key, value ] = _.pairs(_.getQueryParams("?" + query))[0]

			switch key
				
				# convert image to square: ?(s|square)=300
				when "s", "square"
					options.action = "square"
					options.height = sanitizeInput(value)
					options.width = sanitizeInput(value)

				# set the resize width: ?(w|width)=300
				when "w", "width"
					options.action = "resize"
					options.width = sanitizeInput(value)

				# set the resize height: ?(h|height)=300
				when "h", "height"
					options.action = "resize"
					options.height = sanitizeInput(value)

				# crop the image: ?(c|crop)=[w],[h],[crop_x],[crop_y]
				#   - adding 'x' to width or height will resize to that dimension.
				#   eg: ?c=100x,50,center,center
				when "c", "crop"
					opts = value.split(",")
					options.action = "crop"
					options.width = sanitizeInput(opts[0])
					options.height = sanitizeInput(opts[1])
					options.cropX = (if opts[2] then opts[2] else "center")
					options.cropY = (if opts[3] then opts[3] else "center")

			options

		# returns an object literal containing all information for resizing
		getResizeInput: (query, dimension) ->
			resizeOptions = @parseResizeQuery query, dimension

			if resizeOptions.width? and not resizeOptions.height?
				resizeOptions.height = (resizeOptions.width * dimension.height) / dimension.width
			else if resizeOptions.height? and not resizeOptions.width?
				resizeOptions.width = (resizeOptions.height * dimension.width) / dimension.height

			resizeOptions


