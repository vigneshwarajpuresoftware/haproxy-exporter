FROM golang:1.8
MAINTAINER  Yaroslav Molochko <y.molochko@anchorfree.com>

COPY . /go/src/github.com/anchorfree/haproxy-exporter
RUN go get github.com/prometheus/log \
    && go get github.com/prometheus/client_golang/prometheus \
    && CGO_ENABLED=0 go build -a -tags netgo -o /build/haproxy_exporter github.com/anchorfree/haproxy-exporter

FROM alpine
MAINTAINER  Yaroslav Molochko <y.molochko@anchorfree.com>

COPY --from=0 /build/haproxy_exporter /
EXPOSE     9101

ENTRYPOINT ["/haproxy_exporter"]
