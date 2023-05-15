# python3 -m flask --app flaskr run --debug
# python3 -m flask --app flaskr init-db

import os
from flask import Flask, send_from_directory
from . import db
from . import benchmark

def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'flaskr.sqlite'),
    )
    # init db
    db.init_app(app)

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # /benchmark
    app.register_blueprint(benchmark.bp)

    # Path for our main Svelte page
    @app.route("/")
    def base():
        return send_from_directory('../client/public', 'index.html')

    # Path for all the static files (compiled JS/CSS, etc.)
    @app.route("/<path:path>")
    def home(path):
        return send_from_directory('../client/public', path)

    return app