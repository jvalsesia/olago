FROM golang:1.19-alpine AS builder

WORKDIR /build

COPY go.mod .
COPY ola.go .


RUN go build -o ola ola.go

FROM scratch
WORKDIR /app
COPY --from=builder /build/ola /app/ola


ENTRYPOINT ["./ola"]

