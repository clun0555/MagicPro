define [
	"angular"
], (ng) ->

	ng
		.module('app.blog', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "blogcontainer",
					url: "/blog"
					abstract: true
					views: "@":
						templateUrl: "app/blog/views/blog.html"
						controller: "BlogController"

				.state "blog",
					url: ""
					parent: "blogcontainer"					
					templateUrl: "app/blog/views/articles.html"
					controller: "BlogArticlesController"					
					resolve: 
						articles: (BlogService) -> BlogService.getArticles()


				.state "blogbycategory",
					url: "/articles/:category"
					parent: "blogcontainer"		
					templateUrl: "app/blog/views/articles.html"
					controller: "BlogArticlesController"					
					resolve: 
						articles: (BlogService, $stateParams) -> 
							BlogService.getArticlesByCategory($stateParams.category)

				.state "article",
					url: "/blog/:articleId"
					views: "@":
						templateUrl: "app/blog/views/article.html"
						controller: "BlogArticleController"					
						resolve: 
							article: (BlogService, $stateParams) -> BlogService.getArticle($stateParams.articleId) 					
