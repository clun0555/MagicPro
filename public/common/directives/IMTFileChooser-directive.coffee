define [
	"./directives"
], (directives) ->

	directives.directive "imtFileChooser", ->		
		restrict: "A"
		templateUrl: "common/views/file_chooser.html"
		replace: true
		scope: true

		controller: ($scope, $attrs) ->

			params = $scope.$eval($attrs.imtFileChooser)

			uploader = params.uploader ? $scope.uploader

			$scope.size = params.size ? "w=200"

			$scope.classes = $attrs["class"]

			$scope.fileItem = uploader.getFileItem params.model, params.field

			$scope.getImage = ->
				params.model[params.field]

			$scope.changeFile = ($files) ->
				$scope.removeFile() if $scope.fileItem?
				$scope.fileItem = uploader.addFile $files[0], params.model, params.field

			$scope.removeFile = ->
				if $scope.fileItem?
					uploader.removeFile($scope.fileItem)
					$scope.fileItem = null	
				else
					params.model[params.field] = null
		

			

			
							
		