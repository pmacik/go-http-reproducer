FROM registry.access.redhat.com/ubi9/go-toolset:1.19

WORKDIR /opt/app-root/src

COPY server.go server.crt server.key client.go test.sh ./

RUN go mod init github.com/jhutar/go-http-reproducer
RUN go mod tidy
RUN go mod vendor
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o server server.go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o client client.go

USER 65532:65532

CMD bash test.sh
