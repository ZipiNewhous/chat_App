# set base image (host OS)
FROM python:3.8-slim
# set the working directory in the container
WORKDIR /code
ENV PATH_ROOMS "./rooms"
# set FLASK_ENV environment variable to "development"
ENV FLASK_ENV=development
# copy the dependencies file to the working directory
COPY requirements.txt .
# Install dependencies
RUN pip install -r requirements.txt
# copy the content of the templates directory to the working directory
COPY / .
HEALTHCHECK --interval=10s --timeout=3s CMD curl --fail http://localhost/health || exit 1
# command to run on container start
CMD [ "python", "./chatApp.py"]
