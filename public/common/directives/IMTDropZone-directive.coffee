define [
	"jquery"
	"./directives"
], ($, directives) ->

	directives.directive "imtDropZone", ($document) ->
		restrict: "A"
		link: (scope, elem, attr, ctrl) ->
			
			$(elem).bind "dragover", (e) ->		
				e.preventDefault()
				e.stopPropagation()		
				$(elem).addClass("drag-over")

			$(elem).bind "dragleave", (e) ->
				e.preventDefault()
				e.stopPropagation()
				$(elem).removeClass("drag-over")

			elem.bind 'drop', (e) ->

				$(elem).removeClass("drag-over")
				
				e.preventDefault()
				e.stopPropagation()
				
				files =  e.originalEvent.dataTransfer.files
				
				# scope.$apply ->

				scope.$files = files
				scope.$eval attr.imtDropZone

				# scope.$apply()
				
				return false				
				

			