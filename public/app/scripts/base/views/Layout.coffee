define [
	"underscore"
	"marionette"
	"base/utils/ViewHelpers"

], (_, Marionette, ViewHelpers) ->

	class Layout extends Marionette.Layout

		_.extend Layout.prototype, ViewHelpers

		Layout