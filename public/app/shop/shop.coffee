define [
	"angular"
], (ng) ->

	ng
		.module('app.shop', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "order",
					template: '<ui-view/>'
					abstract: true
					data: security: "validated"

				.state "shop", 
					url: "/products"
					abstract: true					
					templateUrl: "app/shop/views/shop.html"
					parent: "order"
									
				.state "shop.categories",
					url: ""
					templateUrl: "app/shop/views/categories.html"
					controller: "ShopCategoriesController"												
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.flushState()
							ShopService.getCategories()

						
				.state "shop.types",
					url: "/:category"					
					templateUrl: "app/shop/views/types.html"
					controller: "ShopTypesController"
					
					resolve: 
						data: ($state, $stateParams, ShopService) ->
							ShopService.flushState()
							ShopService.getCategoryBySlug($stateParams.category)							
			

				.state "shop.products",
					url: "/:category/:type"
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.flushState()
							ShopService.getProductsByCategoryTypeSlug($stateParams.category, $stateParams.type)											
						cart: (CartService) ->	CartService.get()
						
					templateUrl: "app/shop/views/products.html"
					controller: "ShopProductsController"
				


				.state "shop.product",
					url: "/:category/:type/:product"
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getProductBySlug($stateParams.category, $stateParams.type, $stateParams.product)
						cart: (CartService) ->	CartService.get()
					
					templateUrl: "app/shop/views/product.html"
					controller: "ShopProductController"

				.state "cart",
					url: "/cart"
					templateUrl: "app/shop/views/cart_preview.html" 
					controller: "CartPreviewController"
					parent: "order"
					resolve: 
						cart: (CartService) ->	CartService.get()
