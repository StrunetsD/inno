FROM golang:1.21-alpine AS builder


RUN apk add --no-cache git

ENV GO111MODULE=auto \
    CGO_ENABLED=0 \
    GOOS=linux


WORKDIR /build


RUN go mod init gocalc
COPY main.go .
RUN go get github.com/caarlos0/env/v7@v7.1.0 \
    github.com/lib/pq@v1.10.9 \
    github.com/prometheus/client_golang@v1.19.0
RUN go mod tidy


RUN go build -o app -ldflags='-w -s' main.go


FROM alpine:3.10.3


RUN apk add --no-cache postgresql-libs


COPY --from=builder /build/app /app


EXPOSE 7000


CMD ["/app"]