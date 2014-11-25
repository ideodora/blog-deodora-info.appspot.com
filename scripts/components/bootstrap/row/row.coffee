_ = require 'underscore'
Vue = require 'vue'

BootstrapRow = Vue.extend
	name: 'bs-row'
	template: "#row-template"

	# # inherit:true

	computed:
		numCol:
			get: ->
				return _.size(@columns)
	# methods:
	# 	hasSpace: ->
	# 		ret = if @maxCol > @numCol then true else false
	# 		return ret

	created: ->
		debugger

module.exports = BootstrapRow