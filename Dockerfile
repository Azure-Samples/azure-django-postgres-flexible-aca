FROM --platform=linux/amd64 python:3.11
ENV PYTHONUNBUFFERED=1:
ENV PYTHONDONTWRITEBYTECODE=1
RUN python -m pip install --upgrade pip
RUN python -m pip install -r requirements.txt