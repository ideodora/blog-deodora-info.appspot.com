# -*- coding: utf-8 -*-
import webapp2
from webapp2_extras.routes import RedirectRoute

from controllers import home

config = {
    'webapp2_extras.jinja2': {
        "template_path": "views",
        "environment_args": {
            "block_start_string": '{%',
            "block_end_string": '%}',
            "variable_start_string": '[[',
            "variable_end_string": ']]',
            "comment_start_string": '{#',
            "comment_end_string": '#}',
        },
    },
    # 'webapp2_extras.auth': {
    #     'user_model': 'models.user.User',
    #     'user_attributes': ['name']
    # },
    # 'webapp2_extras.sessions': {
    #     'secret_key': 'atRandomStringToSecureSault'
    # }
}

application = webapp2.WSGIApplication([
    RedirectRoute('/', home.Index, name="home"),
    # RedirectRoute('/<type:v|p>/<user_id:\d+>-<signup_token:.+>', userController.Verification, name='verification'),
], debug=True, config=config)
