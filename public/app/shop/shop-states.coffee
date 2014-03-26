define [
	"angular"
], (ng) ->

	ng
		.module('app.shop', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "order",
					abstract: true	
					url: "/products"

				.state "shop",
					abstract: true
					url: ""					
						

				.state "shop.products",
					parent: "order"
					url: ""
					views: "@": 
						resolve: 
							data: ($stateParams, ShopService) ->
								ShopService.getAllProducts()											
							
						templateUrl: "app/shop/views/categories.html"
						controller: "ShopCategoriesController"
						
				.state "shop.productsbycategory",
					parent: "order"
					url: "/products/:category"
					views: "@": 
						resolve: 
							data: ($stateParams, ShopService) ->
								ShopService.getProductsByCategorySlug($stateParams.category)																	
							
						templateUrl: "app/shop/views/products.html"
						controller: "ShopProductsController"				
					

				.state "shop.product",
					parent: "order"
					url: "/products/:category/:type/:product"
					views: "@": 
						resolve: 
							data: ($stateParams, ShopService) ->
								ShopService.getProductBySlug($stateParams.category, $stateParams.type, $stateParams.product)							
						
						templateUrl: "app/shop/views/product.html"
						controller: "ShopProductController"

				.state "shop.editproduct",
					url: "/products/:category/:type/:product/edit"
					parent: "order"
					data: security: "admin"
					views: "@": 
						resolve: 
							data: ($stateParams, ShopService) ->
								ShopService.getProductBySlug($stateParams.category, $stateParams.type, $stateParams.product)					
						templateUrl: "app/shop/views/edit_product.html"
						controller: "ShopProductEditController"

				.state "shop.createproduct",
					url: "/product/new"
					parent: "order"
					data: security: "admin"
					views: "@": 
						resolve: 
							data: (ShopService) -> {}							
						templateUrl: "app/shop/views/edit_product.html"
						controller: "ShopProductEditController"



