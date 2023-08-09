#!/bin/bash

set -e

echo "${0}: running migrations."
python3 manage.py migrate
python3 manage.py loaddata seed_data.json
python3 manage.py collectstatic
python3 -m gunicorn project.wsgi:application \
    --name relecloud
