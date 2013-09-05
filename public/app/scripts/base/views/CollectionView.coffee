define [
  "underscore"
	"marionette"
  "base/utils/ViewHelpers"
	
], (_, Marionette, ViewHelpers) ->

	class CollectionView extends Marionette.CollectionView

  _.extend CollectionView.prototype, ViewHelpers

  CollectionView
		