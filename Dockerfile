FROM registry:latest

RUN apk add --no-cache apache2-utils

WORKDIR /app

COPY . /app

ENTRYPOINT [""]
CMD ["/app/run"]
