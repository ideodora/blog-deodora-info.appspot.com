http = require 'http'
JSONStream = require 'JSONStream'
$ = require 'jquery'

ApplicationController = require './application.coffee'
# Vue = require 'vue'

DemoView = require '../modelViews/home/demo.coffee'

class Home extends ApplicationController
	
	initialize: ->

		console.log 'me home'

		demo = new DemoView()

module.exports = new Home