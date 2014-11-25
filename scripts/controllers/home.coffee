Vue = require 'vue'

ApplicationController = require './application.coffee'

BootstrapTiles = require '../components/bootstrap/tiles/tiles.coffee'

class Home extends ApplicationController
	
	handler: =>

		# Vue.component 'bs-row', BootstrapRow

		@app = new Vue
			el: 'body'
			components:
				"bs-tiles": BootstrapTiles
			created: ->
				@$on 'BootstrapTiles-created', (child) ->
					console.log child
					child.$data.$add 'rows', []
					child.$data.$add 'maxCol', 3
					child.fetch()


module.exports = new Home