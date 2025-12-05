FROM ubuntu:latest
WORKDIR /first_project
COPY . /first_project
RUN apt-get update && apt-get install -y python3
CMD ["python3","hello_world.py"]
