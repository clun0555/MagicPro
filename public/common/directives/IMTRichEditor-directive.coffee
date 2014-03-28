define [
	"./directives"
	"medium-editor"
], (directives, MediumEditor) ->

	directives.directive "imtRichEditor", () ->
		require: "ngModel"
		restrict: "AE"
		link: (scope, iElement, iAttrs, ctrl) ->
			
			angular.element(iElement).addClass "angular-medium-editor"
			
			# Parse options
			opts = {}
			opts = angular.fromJson(iAttrs.options)  if iAttrs.options
			opts.targetBlank = true unless opts.targetBlank?
			placeholder = opts.placeholder or "Type your text"
			onChange = ->
				scope.$apply ->
					
					# If user cleared the whole text, we have to reset the editor because MediumEditor
					# lacks an API method to alter placeholder after initialization
					if iElement.html() is "<p><br></p>"
						opts.placeholder = placeholder
						editor = new MediumEditor(iElement, opts)
					ctrl.$setViewValue iElement.html()
					return

				return

			
			# view -> model
			iElement.on "blur", onChange
			iElement.on "input", onChange
			
			# model -> view
			ctrl.$render = ->
				unless editor
					
					# Hide placeholder when the model is not empty
					opts.placeholder = ""  unless ctrl.$isEmpty(ctrl.$viewValue)
					editor = new MediumEditor(iElement, opts)
				iElement.html (if ctrl.$isEmpty(ctrl.$viewValue) then "" else ctrl.$viewValue)
				return

			return
			