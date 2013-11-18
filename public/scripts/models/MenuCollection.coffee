define [
	"Base"
	"models/MenuModel"
], (Base, MenuModel) ->

	class MenuCollection extends Base.Collection

		defaults: { id: "category", label: "Category" }
		model: MenuModel

		getById: (id)-> return @filter (val)-> return val.get("id") is id

		initialize: -> @.add(new MenuModel(@defaults))