FROM --platform=linux/amd64 python:3.11

ENV DJANGO_SETTINGS_MODULE=project.settings_local

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql-client \
    && apt-get update && apt-get install -y xdg-utils \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*
RUN python -m pip install --upgrade pip

WORKDIR /demo-code

COPY requirements.txt .
COPY entrypoint.sh .

RUN python -m pip install -r requirements.txt
RUN chmod +x entrypoint.sh
COPY . .
# CMD bash -c "sleep infinity"
CMD bash -c ". entrypoint.sh"
