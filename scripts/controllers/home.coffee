http = require 'http'
JSONStream = require 'JSONStream'
$ = require 'jquery'

ApplicationController = require './application.coffee'

ArticleList = require '../modelViews/home/articleList.coffee'

class Home extends ApplicationController
	
	initialize: ->

		console.log 'me home'

		articleList = new ArticleList()

module.exports = new Home