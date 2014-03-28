define [
	"underscore"
	"../blog-states"	
], (_, blog) ->

	blog.controller "BlogArticleEditController", ($scope, $modalInstance, article, BlogService, FileUploadService) ->
		$scope.article = _.clone(article)

		uploader = $scope.uploader = FileUploadService.newUploader($scope)


		doWhenUploaded = (cb) ->
			if uploader.isUploading
				$scope.waitingUpload = true
				uploader.bind "completeall", -> cb()
			else					
				cb()


		$scope.save = ->
			doWhenUploaded ->
				BlogService.save($scope.article).then (article) ->
					console.log article
					$modalInstance.close(article)

		

		$scope.publish = ->
			doWhenUploaded ->
				$scope.article.status = "published"
				$scope.save()
		
		$scope.unpublish = -> 
			$scope.article.status = "draft"
			BlogService.save($scope.article)

		$scope.cancel = ->
			$modalInstance.close(article)	

		$scope.remove = ->
			BlogService.remove($scope.article)
			$modalInstance.close(article)

			





					
		


