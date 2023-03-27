#!/bin/bash

set -e

echo "${0}: running migrations."
python manage.py migrate
python manage.py loaddata seed_data.json
python manage.py collectstatic
gunicorn project.wsgi:application \
    --name relecloud \
    --bind 0.0.0.0:8000 \
    --timeout 600 \
    --workers 4 \
    --log-level=info
