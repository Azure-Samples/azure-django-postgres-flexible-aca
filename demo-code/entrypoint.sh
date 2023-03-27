#!/bin/bash

set -e

echo "${0}: running migrations."
python manage.py migrate --settings=project.settings
python manage.py loaddata --settings=project.settings seed_data.json
gunicorn project.wsgi:application \
    --env DJANGO_SETTINGS_MODULE=project.settings\
    --name relecloud \
    --bind 0.0.0.0:8000 \
    --timeout 600 \
    --workers 4 \
    --log-level=info \
    --reload
