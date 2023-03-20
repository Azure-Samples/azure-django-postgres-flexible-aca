FROM --platform=linux/amd64 python:3.11
ENV PYTHONUNBUFFERED=1:
ENV PYTHONDONTWRITEBYTECODE=1
COPY demo-code/requirements.txt .
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql-client \
     && apt-get update && apt-get install -y xdg-utils \
     && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip
RUN python -m pip install -r requirements.txt
RUN python manage.py migrate
ENTRYPOINT ["python", "manage.py", "runserver"]