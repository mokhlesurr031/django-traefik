# pull the official docker image
FROM python:3.11-slim

# Install the PostgreSQL client library
RUN apt-get update \
    && apt-get install -y libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# set work directory
WORKDIR /app

# set env variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .

# expose the port on which Django's development server runs
EXPOSE 8000

# run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]