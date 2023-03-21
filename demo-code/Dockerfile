FROM --platform=linux/amd64 python:3.11

ENV DJANGO_SETTINGS_MODULE=project.settings_local

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql-client \
    && apt-get update && apt-get install -y xdg-utils \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip

WORKDIR /demo-code
COPY requirements.txt .

RUN python -m pip install -r requirements.txt

COPY . .
# CMD bash -c ls
CMD bash -c "sleep infinity"
# CMD bash -c "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"