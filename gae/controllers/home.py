# -*- coding:utf-8 -*-
from base import BaseController
# from system.util import Date


class Index(BaseController):
    """docstring for IndexController"""
    def get(self):
        context = {"message": u"hello world!"}
        self.render_response('index.html', **context)
