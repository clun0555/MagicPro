###
	Heavily inspired from https://github.com/punkave/mongoose-uniqueslugs
	Made a few changes. added regenerateOnUpdate to keep slug up-to-date on updates
###

exports.plugin = (schema, options) ->
	options.source ?= "title"
	options.regenerateOnUpdate ?= true
	
	# Everything except letters and digits becomes a dash. All modern browsers are
	# fine with UTF8 characters in URLs. If you don't like this, pass your own regexp
	# to match disallowed characters
	options.disallow = /[^\w\d]+/g  if options.disallow is `undefined`
	options.substitute = "-"  if options.substitute is `undefined`
	unless options.addSlugManually
		schema.add slug:
			type: String
			unique: true

	
	# "Wait, how does the slug become unique?" See enhanceModel below. We add digits to it
	# if and only if there is an actual error on save. This approach is concurrency safe
	# unlike the usual "hope nobody else makes a slug while we're still saving" strategy
	schema.pre "save", (next) ->
		
		if options.regenerateOnUpdate or not @get("slug")
			
			# Come up with a unique slug, even if the title is not unique
			originalSlug = @get(options.source)
			originalSlug = originalSlug.toLowerCase().replace(options.disallow, options.substitute)
			
			# Lop off leading and trailing -
			if originalSlug.length
				originalSlug = originalSlug.substr(1)  if originalSlug.substr(0, 1) is options.substitute
				originalSlug = originalSlug.substr(0, originalSlug.length - 1)  if originalSlug.substr(originalSlug.length - 1, 1) is options.substitute
			@set "slug", originalSlug
		
		next()

exports.enhanceModel = (model) ->
	
	# Stash the original 'save' method so we can call it
	model::saveAfterExtendSlugOnUniqueIndexError = model::save
	
	# Replace 'save' with a wrapper
	model::save = (f) ->
		
		# Our replacement callback
		extendSlugOnUniqueIndexError = (err, d) =>
			if err
				
				# Spots unique index errors relating to the slug field
				if (err.code is 11000) and (err.err.indexOf("slug") isnt -1)
					@slug += (Math.floor(Math.random() * 10)).toString()
					
					# Necessary because otherwise Mongoose doesn't allow us to retry save(),					
					@isNew = true
					@save extendSlugOnUniqueIndexError
					return
			
			# Not our special case so call the original callback
			f err, d

		
		# Call the original save method, with our wrapper callback
		@saveAfterExtendSlugOnUniqueIndexError extendSlugOnUniqueIndexError

