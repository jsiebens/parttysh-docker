FROM --platform=${BUILDPLATFORM:-linux/amd64} golang:1.17.2-alpine3.14 as build
RUN apk add --no-cache git
WORKDIR /data
RUN git clone --depth 1 --branch v0.1.0 https://github.com/caarlos0/parttysh.git
WORKDIR /data/parttysh
RUN go build .

FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine:3.14.2 as ship
COPY --from=build /data/parttysh/parttysh /usr/local/bin
ENTRYPOINT ["parttysh"]
