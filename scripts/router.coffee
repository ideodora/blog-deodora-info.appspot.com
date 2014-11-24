page = require 'page'

home = require './controllers/home.coffee'

class Router
	start: ->
		page '/', home.handler
		page
			click: false
			popstate: false
	

module.exports = Router