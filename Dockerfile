FROM python:3.11.0-slim-buster
LABEL maintainer="gkarabetskii@gmail.com"

ENV PYTHONUNBUFFERED 1

WORKDIR app/


COPY requirements.txt requirements.txt

RUN apt-get update && apt-get -y install libpq-dev gcc

RUN pip install -r requirements.txt

COPY cinema_service .

RUN mkdir -p /vol/app/media

RUN adduser \
    --disabled-password \
    --no-create-home \
    django-user

RUN chown -R django-user:django-user /vol/
RUN chmod -R 755 /vol/app/

USER django-user
