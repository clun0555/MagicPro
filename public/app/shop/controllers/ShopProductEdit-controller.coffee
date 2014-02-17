define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopProductEditController", ($scope, data, ShopService, $state, $stateParams, ProductService, FileUploadService, CartService, $modal) ->
			
		uploader = $scope.uploader = FileUploadService.newUploader($scope)

		$scope.product = data?.product ? { featured: false,  inner: 1, designs: [ {} ] }

		if $scope.$parent.files?
			# Arrived in this state by droping a file... lets add it to our product
			files = $scope.files
			$scope.$parent.files = null
			uploader.addFile(files[0], $scope.product, "image") if files[0]?			

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

			resetServerError: ->
				$scope.serverError = null

			save: ->
				$scope.serverError = null
				$scope.saving = true

				
				doSave = ->
					$scope.submited = true

					unless $scope.productform.$valid
						$scope.saving = false
						return


					product = _.clone ($scope.product)
					product.type = product.type._id
					
					ShopService.saveProduct(product).then( 
						-> 
							CartService.removeUnexistingCompositions product
							$state.go "shop.products"
						(res) ->
							# currently only one thing could go wrong
							$scope.serverError = "duplicate.identifier"
							$scope.saving = false
					)

				if uploader.isUploading
					uploader.bind "completeall", -> doSave()
				else					
					doSave()	

			open: ->
				$modal.open(
					templateUrl: "app/shop/views/category_chooser.html"
					controller: "CategoryChooserController"
					resolve:
						categories: (ShopService) -> ShopService.getCategories()
						currentType: -> $scope.product.type
							
				).result.then (type) ->
					$scope.product.type = type
				



