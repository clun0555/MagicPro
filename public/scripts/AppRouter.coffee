define [
	"Base"
	"App"
], (Base, App) ->

	class AppRouter extends Base.Router

		routes: 

			"": "app:root"
			"login": "app:login"
			"register": "app:register"
			
			"products": "product:show:categories"
			"products/:categorieIdentifier": "product:show:types"
			"products/:categorieIdentifier/:typeIdentifier": "product:show:products"
			"products/:categorieIdentifier/:typeIdentifier/:productIdentifier": "product:show:product"

			"admin": "admin:show"
			"admin/users": "admin:user:index"
			"admin/users/new": "admin:user:create"
			"admin/users/:id": "admin:user:edit"