define [
  "underscore"
	"marionette"
	"base/utils/ViewHelpers"

], (_, Marionette, ViewHelpers) ->

	class ItemView extends Marionette.ItemView

  _.extend ItemView.prototype, ViewHelpers

  ItemView