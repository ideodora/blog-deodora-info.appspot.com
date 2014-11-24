$ = require 'jquery'
Bootstrap = require 'bootstrap'
Router = require './router.coffee'

do ->
	$ ->
		router = new Router()
		router.start()