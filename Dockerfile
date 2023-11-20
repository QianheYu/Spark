# Build Server
FROM node:latest AS build-web
WORKDIR /Spark
COPY . .
RUN make web

FROM docker.io/golang:alpine AS build-server
WORKDIR /Spark
RUN apk update && apk add make git
COPY --from=build-web /Spark/ .
RUN make server-releases
RUN ./rename-server.sh

FROM docker.io/alpine:latest
WORKDIR /app
COPY --from=build-server /Spark/releases/spark .
CMD [ "/app/spark" ]