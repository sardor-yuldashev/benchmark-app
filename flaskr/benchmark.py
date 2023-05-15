import json
from flask import Response
from flaskr.db import get_db
from flask import Blueprint, flash, g, redirect, render_template, request, session, url_for

bp = Blueprint('benchmark', __name__, url_prefix='/benchmark')

@bp.route('/stations', methods=['GET'])
def stations():
    db = get_db()
    # query all stations
    query = db.execute('SELECT * FROM stations').fetchall()
    # convert to sql rows to tuples
    results = [tuple(row) for row in query]
    json_string = json.dumps(results)
    return json_string

@bp.route('/participants/<station_id>', methods=['GET'])
def participants(station_id):
    db = get_db()
    # query participants of station
    query = db.execute('SELECT * FROM participants WHERE station_id = ?', (station_id,)).fetchall()
    # convert to sql rows to tuples
    results = [tuple(row) for row in query]
    json_string = json.dumps(results)
    return json_string

@bp.route('/videos/<participant_id>', methods=['GET'])
def videos(participant_id):
    db = get_db()
    # query videos of participant
    query = db.execute('SELECT * FROM videos WHERE participant_id = ?', (participant_id,)).fetchall()
    # convert to sql rows to tuples
    results = [tuple(row) for row in query]
    json_string = json.dumps(results)
    return json_string