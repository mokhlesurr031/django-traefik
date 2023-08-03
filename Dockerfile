# pull official base image
FROM python:3.9.6-alpine

WORKDIR /app


# Install the PostgreSQL client library
# install dependencies
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev


RUN pip install --upgrade pip


# set env variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .

ENTRYPOINT ["python", "manage.py"]
EXPOSE 8000
CMD ["runserver", "0.0.0.0:8000"]