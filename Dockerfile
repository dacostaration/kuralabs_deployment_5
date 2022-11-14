FROM python

# RUN apt update 

WORKDIR /app

ADD ./tarball.tar.gz .

RUN pip install -r requirements.txt pip install gunicorn

EXPOSE 5000

# ENTRYPOINT ["FLASK run"]
ENTRYPOINT FLASK_APP=app flask run --host=0.0.0.0
