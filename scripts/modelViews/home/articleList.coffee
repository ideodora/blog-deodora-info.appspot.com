http = require 'http'
JSONStream = require 'JSONStream'
Vue = require 'vue'

class ArticleList
	
	constructor: ->
		@vm = new Vue
			el: '#articles'
			data:
				articles: []

		@fetch()


	parse: (res) =>
		titles = res.pipe(JSONStream.parse('.title'))
		titles.on 'data', (data) =>

			article =
				done: false
				content: data

			@vm.articles.push article


	fetch: ->
		req = http.request
			host: 'blog.deodora.info'
			path: "/wp-json/posts"
			method: "GET"
			withCredentials: true
		, @parse

		req.end()

		req.on 'response', (res) ->
			console.log 'X-WP-Total: ' + res.getHeader('X-WP-Total')
			console.log 'X-WP-TotalPages: ' + res.getHeader('X-WP-TotalPages')

module.exports = ArticleList