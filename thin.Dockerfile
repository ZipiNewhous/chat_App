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

# set FLASK_ENVs
ENV PATH_ROOMS "./rooms"

ENV PATH_USERS "./users.csv"

# set FLASK_ENV environment variable to "development"
ENV FLASK_ENV=development

# HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=3s --start-period=30s CMD curl -f http://localhost:5000/health

# command to run on container start
CMD [ "python", "./chatApp.py"]
