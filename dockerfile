FROM python:latest

RUN  apt update

RUN  apt upgrade -y

RUN apt install -y net-tools

WORKDIR /app

#ADD ./pythonapp.tar.gz .
ADD static /app/static
ADD templates /app/templates
ADD application.py /app/
ADD requirements.txt /app/

RUN pip install pip --upgrade
RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT FLASK_APP=application flask run --host=0.0.0.0