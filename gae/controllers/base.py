# -*- coding:utf-8 -*-

import webapp2

from webapp2_extras import jinja2

import json


class BaseController(webapp2.RequestHandler):

    @webapp2.cached_property
    def jinja2(self):
        return jinja2.get_jinja2(app=self.app)

    def render_response(self, _template, **context):
        rv = self.jinja2.render_template(_template, **context)
        self.response.write(rv)

    def render_json(self, obj):
        rv = json.dumps(obj)
        self.response.content_type = "application/json"
        self.response.write(rv)

    def render_json_result(self, result):
        self.render_json({'result': result})
