http = require 'http'
JSONStream = require 'JSONStream'
Vue = require 'vue'

class ArticleList
	
	constructor: ->
		@vm = new Vue
			el: '#articles'
			data:
				rows: [
					articles: []
				]
				rowIndex: -1
				articleIndex: -1
			methods:
				appendArticleFirst: (article) ->
					this.rows[0].articles.push article
					this.rowIndex = 0
					this.articleIndex = 1

				appendArticle: (article) ->

					console.log 'start'
					console.log "rowIndex:" + this.rowIndex
					console.log "articleIndex:" + this.articleIndex

					if this.rowIndex is -1 and this.articleIndex is -1
						return this.appendArticleFirst(article)		

					if this.articleIndex is 0
						row =
							articles: []

						this.rows.push row
						this.rowIndex++

					this.rows[this.rowIndex].articles.push article

					if this.articleIndex is 2
						this.articleIndex = 0
					else
						this.articleIndex++
						



					console.log "done"
					console.log "rowIndex:" + this.rowIndex
					console.log "articleIndex:" + this.articleIndex


		@fetch()


	parse: (res) =>
		articles = []
		titles = res.pipe(JSONStream.parse('.title'))
		titles.on 'data', (data) =>

			# mod3 = vm.counter % 3
			# firstColumn = mod3 is 0
			# lastColumn = mod3 is 2

			article =
				done: false
				content: data

			@vm.appendArticle(article)
			# articles.push article
				# lastColumn: lastColumn 

			# @vm.articles.push article

			# @vm.counter++

		# titles.on 'end', =>

		# 	for article in articles
		# 		mod3 = vm.counter % 3
		# 		firstColumn = mod3 is 0
		# 		lastColumn = mod3 is 2

		# 		lastRow = @vm.rows.slice(-1)
		# 		if lastRow.length < 3




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