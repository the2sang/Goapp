FROM golang:1.15-alpine3.12 AS gobuilder-stage

MAINTAINER Charry, Kang <the2sang@gmail.com>
LABEL "purpose"="Service Development using Multi-stage builder."

WORKDIR /usr/src/goapp

COPY goapp.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /usr/local/bin/gostart

FROM scratch AS runtime-stage

COPY --from=gobuilder-stage /usr/local/bin/gostart /usr/local/bin/gostart

CMD ["/usr/local/bin/gostart"]
