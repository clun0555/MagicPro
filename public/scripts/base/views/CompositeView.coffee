define [
	"underscore"
	"marionette"
	"base/utils/ViewHelpers"

], (_, Marionette, ViewHelpers) ->

	class CompositeView extends Marionette.CompositeView

		_.extend CompositeView.prototype, ViewHelpers

		CompositeView
