#!/bin/bash

case "$1" in
    develop)
        echo "Running Development Server"
        FLASK_APP=main.py flask db upgrade
        exec python main.py
        ;;
    test)
        echo "Test (not yet)"
        ;;
    start)
        echo "Running Start"
        FLASK_APP=main.py flask db upgrade
        exec gunicorn -c gunicorn.py gefapi.wsgi:application
        ;;
    worker)
        echo "Running celery"
        exec celery -A gefapi.celery worker -E -B --loglevel=DEBUG
        ;;
    *)
        exec "$@"
esac
