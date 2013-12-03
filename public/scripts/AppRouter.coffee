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
			"products/:categorySlug": "product:show:types"
			"products/:categorySlug/:typeSlug": "product:show:products"
			"products/:categorySlug/:typeSlug/:productSlug": "product:show:product"
			"cart": "product:show:cart"

			"admin": "admin:show"
			"admin/users": "admin:user:index"
			"admin/users/new": "admin:user:create"
			"admin/users/:id": "admin:user:edit"