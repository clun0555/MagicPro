define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopProductEditController", ($scope, data, ShopService, $state, $stateParams, ProductService, FileUploadService) ->
			
		uploader = $scope.uploader = FileUploadService.newUploader($scope)

		$scope.product = data.product ? { designs: [], type: data.type }

		if $scope.$parent.files?
			# Arrived in this state by droping a file... lets add it to our product
			files = $scope.files
			$scope.$parent.files = null
			uploader.addFile(files[0], $scope.product, "image") if files[0]?			

		# droping a file anywhere will set our product main image
		# $scope.$on "fileDrop", (event, files) -> 
			# uploader.addFile(files[0], $scope.product, "image") if files[0]?				

		_.extend $scope, 

			addDesigns: ($files) ->
				$scope.addDesign file for file in $files
											
			addDesign: (file) ->
				design = {}
				design.identifier = ProductService.getNextDesignIdentifier($scope.product)
				uploader.addFile(file, design, "image") if file?
				$scope.product.designs.push design

			removeDesign: (design) ->
				uploader.removeByModel design, "image"

				index = $scope.product.designs.indexOf design
				$scope.product.designs.splice index, 1

			save: ->

				$scope.saving = true

				
				doSave = ->

					product = _.clone ($scope.product)
					product.type = product.type._id
					
					product.slug = _.slugify(product.title)

					ShopService.saveProduct(product).then -> $state.go "shop.products"

				if uploader.isUploading
					uploader.bind "completeall", -> doSave()
				else					
					doSave()	


