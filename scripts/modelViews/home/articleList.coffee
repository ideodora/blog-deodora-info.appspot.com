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
		mod = 0
		titles.on 'data', (data) =>
			mod3 = mod % 3
			lastColumn = mod3 is 2

			article =
				done: false
				content: data
				lastColumn: lastColumn 

			@vm.articles.push article

			mod++



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