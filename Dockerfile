FROM golang:1.22 AS BUILD



COPY . /go/src/github.com/itcrow/clickhouse_exporter

WORKDIR /go/src/github.com/itcrow/clickhouse_exporter

RUN  make


FROM gcr.io/distroless/static-debian12

COPY --from=BUILD /go/bin/clickhouse_exporter /usr/local/bin/clickhouse_exporter
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/local/bin/clickhouse_exporter"]
CMD ["-scrape_uri=http://localhost:8123"]
EXPOSE 9116
