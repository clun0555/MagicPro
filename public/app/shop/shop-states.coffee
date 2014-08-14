define [
	"angular"
], (ng) ->

	ng
		.module('app.shop', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "order",
					template: "<div ui-view autoscroll='true'  ></div>"
					abstract: true
					# data: security: "validated"					
					data: security: (user) -> 
						# cant access if not logged in
						return false unless user?
						# show validating message if user is not validated yet (expect if admin)
						return "validating" if user.role isnt "admin" and user.status isnt "validated"
						# otherwise grant access
						return true

					parent: "layout"
					resolve: 
						cart: (CartService) ->
							CartService.get()

				.state "home",
					url: "/home"
					templateUrl: "app/shop/views/home.html" 
					# controller: "CartPreviewController"
					parent: "layout"	
					# parent: "order"	
					controller: "ShopHomeController"
					resolve: 
						data: (ShopService) ->
							ShopService.getAllProducts()

				.state "contact",
					url: "/contact"
					templateUrl: "app/shop/views/contact.html" 					
					parent: "layout"	


				.state "about",
					url: "/about"
					templateUrl: "app/shop/views/about.html" 					
					parent: "layout"	
					
					
					

				.state "shop", 
					url: "/products"
					abstract: true					
					parent: "order"
					templateUrl: "app/shop/views/shop.html"
					


				.state "shop.navigator", 
					abstract: true
					views: 
						"side@":
							templateUrl: "app/shop/views/side_categories.html"
							controller: "ShopSideCategoriesController"
							resolve: 
								data: ($stateParams, ShopService) ->
									ShopService.getCategories()

						"": 
							template: "<div ui-view autoscroll='false'></div>"

			
				.state "shop.search",
					parent: "shop.navigator"
					url: "/search/:searchInput"
					template: "<div ui-view autoscroll='false'></div>"
					resolve:
						data: ($stateParams, ShopService) ->
							ShopService.searchProduct($stateParams.searchInput)
						cart: (CartService) ->	CartService.get()

					controller: (data, $scope, $stateParams, ShopService) ->
						ShopService.search.title = $stateParams.searchInput ? ""
						$scope.searchQuery = $stateParams.searchInput ? ""

						if data.products.length is 1
							data.product = data.products[0]
							$scope.$state.go "shop.search.single"
						else
							$scope.$state.go "shop.search.multiple"

					onExit: (ShopService) ->
						ShopService.search.title = null

				.state "shop.search.multiple",
					parent: "shop.search"
					templateUrl: "app/shop/views/products.html"
					controller: "ShopProductsController"
						
				.state "shop.search.single",
					parent: "shop.search"
					templateUrl: "app/shop/views/product.html"
					controller: "ShopProductController"
						

				.state "shop.products",
					parent: "shop.navigator"
					url: ""
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getAllProducts()											
						cart: (CartService) ->	CartService.get()
						
					templateUrl: "app/shop/views/products.html"
					controller: "ShopProductsController"
						
				.state "shop.productsbycategory",
					parent: "shop.navigator"
					url: "/:category"
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getProductsByCategorySlug($stateParams.category)											
						cart: (CartService) ->	CartService.get()
						
					templateUrl: "app/shop/views/products.html"
					controller: "ShopProductsController"

				.state "shop.productsbytype",
					parent: "shop.navigator"
					url: "/:category/:type"
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getProductsByCategoryTypeSlug($stateParams.category, $stateParams.type)											
						cart: (CartService) ->	CartService.get()
						
					templateUrl: "app/shop/views/products.html"
					controller: "ShopProductsController"
				

				.state "shop.product",
					parent: "shop.navigator"
					url: "/:category/:type/:product"
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getProductBySlug($stateParams.category, $stateParams.type, $stateParams.product)
						cart: (CartService) ->	CartService.get()
					
					templateUrl: "app/shop/views/product.html"
					controller: "ShopProductController"

				.state "shop.editproduct",
					url: "/products/:category/:type/:product/edit"
					parent: "order"
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getProductBySlug($stateParams.category, $stateParams.type, $stateParams.product)					
					data: security: "admin"
					templateUrl: "app/shop/views/edit_product.html"
					controller: "ShopProductEditController"

				.state "shop.createproduct",
					url: "/product/new"
					parent: "order"
					resolve: 
						data: (ShopService) -> {}
						# product: {}
					data: security: "admin"
					templateUrl: "app/shop/views/edit_product.html"
					controller: "ShopProductEditController"

				.state "cart",
					url: "/cart"
					templateUrl: "app/shop/views/cart_preview.html"
					controller: "CartPreviewController"
					parent: "order"

				.state "checkout",
					url: "/checkout"
					templateUrl: "app/shop/views/checkout.html" 
					parent: "order"	


