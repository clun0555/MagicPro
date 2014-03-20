define [
	"jquery"
	"./directives"
], ($, directives) ->

	directives.directive "imtFileChooser", ->		
		restrict: "A"
		templateUrl: "common/views/file_chooser.html"
		replace: true
		scope: true

		controller: ($scope, $attrs, $element, ImageSizeService) ->

			params = $scope.$eval($attrs.imtFileChooser)

			uploader = params.uploader ? $scope.uploader

			$scope.uploadIcon = params.icon ? 'fa-arrow-circle-o-up'

			$scope.size = params.size ? "w=200"

			$scope.fileItem = uploader.getFileItem params.model, params.field

			$scope.getImage = ->
				params.model[params.field]	

			$scope.hasImage = ->
				$scope.fileItem? or $scope.getImage()?

			$scope.changeFile = ($files) ->
				
				if $scope.fileItem?
					uploader.removeFile($scope.fileItem)					
				else
					params.model[params.field] = null

				$scope.fileItem = uploader.addFile $files[0], params.model, params.field

			$scope.removeFile = ->
				if $scope.fileItem?
					uploader.removeFile($scope.fileItem)
					$scope.fileItem = null	
				else
					params.model[params.field] = null	

				resize()

				return

			$scope.resize = resize = ->
				dim = $scope.fileItem?.dim or $scope.getImage() or { width: 1000, height: 1000 }
				resizeOptions = ImageSizeService.getResizeInput($scope.size, dim)
				$($element).find(".image-chooser").css height: resizeOptions.height

			resize()

			uploader.bind "afterimageloaded", (evemt, fileItem) ->
				if fileItem is $scope.fileItem
					$scope.currentImage = $scope.fileItem.image

					

					

		# link: ($scope, element, $attrs) ->

			


		

			

			
							
		