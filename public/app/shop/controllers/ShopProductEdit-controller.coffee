define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopProductEditController", ($scope, data, ShopService, $state, $stateParams, ProductService, FileService) ->
			
		$scope.product = data.product ? { designs: [], type: data.type }

		if $scope.$parent.files?
			# Arrived in this state by droping a file... lets add it to our product
			files = $scope.files
			$scope.$parent.files = null
			$scope.setProductImage files	

		# droping a file anywhere will set our product main image
		$scope.$on "fileDrop", (event, $files) -> $scope.setProductImage($files)				

		_.extend $scope, 

			addDesigns: ($files) ->
				for file in $files
					$scope.addDesign { imageItem: FileService._addToQueue(file) }
											
			addDesign: (design = {}) ->
				design.identifier = ProductService.getNextDesignIdentifier()
				$scope.product.designs.push design

			removeDesign: (design) ->
				index = $scope.product.designs.indexOf design
				$scope.product.designs.splice index, 1
				
				FileService.removeFile design, "image"
				

			setProductImage: ($files) ->
				
				FileService.setFile $scope.product, "image", $files[0]				
			
			removeImage: (model) ->				
				FileService.removeFile model, "image"


			changeDesignImage: (design, $files) ->
				FileService.setFile design, "image", $files[0]

			save: ->
				product = _.clone ($scope.product)
				product.type = product.type._id
				
				if product.imageItem?
					product.image = {
						path: product.imageItem.imageId
						width:  product.imageItem.dim.width
						height:  product.imageItem.dim.height
					}

				# product.imageId = product.imageItem.imageId if product.imageItem?
				product.imageItem = null
				product.slug = _.slugify(product.title)

				designs = []
				for design, index in product.designs
					design = _.clone design
					# design.imageId = design.imageItem.imageId if design.imageItem?
					if design.imageItem?
						design.image = {
							path: design.imageItem.imageId
							width:  design.imageItem.dim.width
							height:  design.imageItem.dim.height
						}
					design.imageItem = null
					designs.push design

				product.designs = designs


				ShopService.saveProduct(product).then ->
					$state.go "shop.products"