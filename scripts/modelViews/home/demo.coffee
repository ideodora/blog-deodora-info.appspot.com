http = require 'http'
JSONStream = require 'JSONStream'
Vue = require 'vue'

class DemoView
	
	constructor: ->
		@vm = new Vue
			el: '#demo'
			data:
				title: '弊社が自信を持ってオヌヌメします'
				todos: []

		@fetch()


	parse: (res) =>
		article = res.pipe(JSONStream.parse('.title'))
		article.on 'data', (data) =>

			todo =
				done: false
				content: data

			@vm.todos.push todo


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

module.exports = DemoView