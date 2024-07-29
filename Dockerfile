FROM python:3.9-alpine

ENV PYTHONUNBUFFERED=1 \
    APP_HOME=/app

WORKDIR $APP_HOME

RUN apk update && apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    python3-dev \
    postgresql-dev \
    && pip install --upgrade pip

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

VOLUME /app/data

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
