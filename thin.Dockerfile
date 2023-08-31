# set base image (host OS)
FROM python:3.8-slim as builder 
# set the working directory in the container
WORKDIR /code
# copy the dependencies file to the working directory
COPY requirements.txt .
# Install dependencies
RUN pip install -r requirements.txt --no-cache-dir
# copy the content of the templates directory to the working directory
COPY / .

FROM builder

WORKDIR /code

COPY --from=builder /code /code

ENV PATH_ROOMS "./rooms"
# set FLASK_ENV environment variable to "development"
ENV FLASK_ENV=development
# command to run on container start
CMD [ "python", "./chatApp.py"]
