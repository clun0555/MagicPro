define [
	"underscore"
	"./shop-states"
	"common/models/Cart"
], (_, shop, Cart) ->
	
	shop
		
		.controller "ShopCategoriesController", ($scope, data, ShopService) ->						
			$scope.categories = data.categories
			$scope.search = ShopService.search

		.controller "ShopTypesController", ($scope, data, ShopService) ->
			$scope.category = data.category
			$scope.search = ShopService.search

		.controller "ShopProductsController", ($scope, data, cart, ShopService, CartService, $state) ->
			$scope.products = data.products
			$scope.search = ShopService.search
			$scope.cart = cart

			$scope.quantities = {}

			for product in data.products
				$scope.quantities[product._id] = cart.quantities(product)

			$scope.updateQuantity = (product, design) ->
				quantity = $scope.quantities[product._id][design._id]
				CartService.update product, design, quantity

			$scope.navigateToProduct = (product) ->
				if $scope.hover is product
					$state.go 'shop.product', { category: product.type.category.slug, type: product.type.slug, product: product.slug}				

			$scope.activateProductHover = (product) ->				
				# prevent ipad unwanted hover on click 
				if not _.has(document.documentElement, 'ontouchstart')
					$scope.hover = product 
				

			$scope.unActivateProduct = (product) ->
				return if $scope.hover isnt product
				$scope.hover = null
				return

			$scope.activateProductClick = (product) ->
				return if $scope.hover is product
				$scope.hover = product 
				setTimeout ->
					angular.element(".product_#{product._id} .design_quantity_0").focus()
				, 0
				return

			$scope.focusDesign = (design, $scope) ->
				$scope.focusedDesign = design
				return 

			$scope.blurDesign = ($scope) ->
				$scope.focusedDesign = null
				return 

			$scope.getImageId = (product, design, $scope) ->
				return design.imageId if design.imageId?
				product.imageId

			$scope.$on "fileDrop", (event, $files) ->
				$scope.$parent.files = $files
				$state.go "shop.createproduct", { category: product.type.category.slug, type: product.type.slug, product: product.slug}

		
		.controller "ShopProductController", ($scope, data, cart, CartService) ->
			$scope.product = data.product					
			$scope.cart = cart
			$scope.quantities = cart.quantities(data.product)

			$scope.updateQuantity = (design) ->
				quantity = $scope.quantities[design._id]
				CartService.update $scope.product, design, quantity

		.controller "ShopProductEditController", ($scope, data, ShopService, UuidService, $state, $fileUploader, $stateParams) ->
			
			$scope.product = data.product ? { designs: [], type: data.type }

			uploader = $scope.uploader = $fileUploader.create({
				scope: $scope,
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
				item.imageId = UuidService.generate() + ".jpg"
				item.formData[0].key = item.imageId

			addToQueue = (file) ->
				uploader.addToQueue(file)
				fileItem = $scope.uploader.queue[$scope.uploader.queue.length - 1]
				fileItem

			guessNextDesignId = ->
				
				counter = 0

				prefix = $scope.product.designs?[0]?.identifier?[0]
				prefix ?= "S" 

				for design in $scope.product.designs 
					if design.identifier?.length is 3
						num = parseInt(design.identifier.substring(1, 3), 10)
						counter = num if not _.isNaN(num) and num > counter

				counter += 1

				s = "000000000" + counter
				padCounter = s.substr(s.length - 2)

				prefix + padCounter
			
			$scope.addDesigns = ($files) ->

				for file in $files
					$scope.addDesign { imageItem: addToQueue(file) }
											
			$scope.addDesign = (design = {}) ->
				design.identifier = guessNextDesignId()
				$scope.product.designs.push design

			$scope.removeDesign = (design) ->
				index = $scope.product.designs.indexOf design
				$scope.product.designs.splice index, 1
				design.imageItem?.remove()

			$scope.setProductImage = ($files) ->
				
				item = addToQueue($files[0])

				$scope.product.imageItem = false
				$scope.$apply()
				$scope.product.imageItem = item
				$scope.$apply()
			
			# global file drop	
			$scope.$on "fileDrop", (event, $files) ->
				$scope.setProductImage($files)


			$scope.removeImage = (element) ->
				if element.imageId?
					element.imageId = null
				else if element.imageItem?
					element.imageItem.cancel()
					element.imageItem.remove()
					element.imageItem = null



			$scope.changeDesignImage = (design, $files) ->
				design.imageItem = false
				$scope.$apply()
				design.imageItem = addToQueue($files[0])
				$scope.$apply()


			$scope.save = ->
				product = _.clone ($scope.product)
				product.type = product.type._id
				product.imageId = product.imageItem.imageId if product.imageItem?
				product.imageItem = null
				product.slug = _.slugify(product.title)


				designs = []
				for design, index in product.designs
					design = _.clone design
					design.imageId = design.imageItem.imageId if design.imageItem?
					design.imageItem = null
					designs.push design

				product.designs = designs


				ShopService.saveProduct(product).then ->
					$state.go "shop.products"

			if $scope.$parent.files?
				files = $scope.files
				$scope.$parent.files = null
				$scope.setProductImage files
				
		.controller "BreadCrumbController", ($scope, $rootScope, ShopService, $state) ->
						
			$scope.$watch '$state.$current.locals.globals.data', (data) ->
				$scope.data = data
				$scope.search = ShopService.search

			$scope.searchProduct = ->
				$state.go "shop.search", searchInput: ShopService.search.title

		.controller "CartController", ($scope, CartService) ->
			
			CartService.get().then (cart) -> $scope.cart = cart
				

		.controller "CartPreviewController", ($scope, cart, CartService) ->
			
			$scope.cart = cart.clone()			
			
			$scope.submit = ->
				CartService.save().then ->
					$scope.saved = true	

			$scope.remove = (bundle, composition) ->
				# remove in master cart
				CartService.update bundle.product, composition.design, 0

				# remove in cart preview
				$scope.cart.updateBundle bundle.product, composition.design, 0


			$scope.updateQuantity = (design, product, quantity) ->
				CartService.update product, design, quantity
		




