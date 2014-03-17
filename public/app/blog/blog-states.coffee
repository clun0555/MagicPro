define [
	"angular"
], (ng) ->

	ng
		.module('app.blog', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "blog",
					url: "/blog"
					templateUrl: "app/blog/views/articles.html"
					controller: "BlogArticlesController"
					parent: "layout"
					resolve: 
						articles: (BlogService) -> BlogService.getArticles() 

				.state "article",
					url: "/blog/:articleId"
					templateUrl: "app/blog/views/article.html"
					controller: "BlogArticleController"
					parent: "layout"
					resolve: 
						article: (BlogService, $stateParams) -> BlogService.getArticle($stateParams.articleId) 					
