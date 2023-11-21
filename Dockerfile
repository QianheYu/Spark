# Build Server
FROM node:latest AS build-web
WORKDIR /Spark
COPY . .
RUN make web

FROM golang:latest AS build-server
WORKDIR /Spark
# RUN apk update && apk add make git
COPY --from=build-web /Spark/ .
RUN make server-releases
RUN ./rename-server.sh
RUN make client

FROM alpine:latest
WORKDIR /app
COPY --from=build-server /Spark/releases/spark .
COPY --from=build-server /Spark/built .
CMD [ "/app/spark" ]