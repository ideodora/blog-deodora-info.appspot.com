http = require 'http'
JSONStream = require 'JSONStream'
Vue = require 'vue'

BootstrapRow = require '../row/row.coffee'

BootstrapTiles = Vue.extend
	name: 'bs-tiles'
	template: "#tiles-template"
	components:
		"bs-row": BootstrapRow
	computed:
		lastRow: ->
			@rows[@rows.length - 1]
		lastRowIndex: ->
			@rows.length - 1
	methods:
		hasSpace: ->
			if @lastRow?.columns.length < @maxCol then true else false
		appendArticle: (article) ->
			unless @hasSpace() is yes
				return @appendRow(article)
			@rows[@lastRowIndex].columns.push article

		appendRow: (article) ->
			@rows.push
				columns: [
					article
				]

		fetch: ->
			req = http.request
				host: 'blog.deodora.info'
				path: "/wp-json/posts"
				method: "GET"
				withCredentials: true
			, @parse

			req.end()

			req.on 'resposne', (res) ->
				console.log 'X-WP-Total: ' + res.getHeader('X-WP-Total')
				console.log 'X-WP-TotalPages: ' + res.getHeader('X-WP-TotalPages')

		parse: (res) ->
			parsers = res.pipe(JSONStream.parse('.*'))
			parsers.on 'data', (data) =>
				article =
					done: false
					title: data.title
					excerpt: data.excerpt
					link: data.link

				@appendArticle(article)

	created: ->
		@$dispatch('BootstrapTiles-created', @)


module.exports = BootstrapTiles