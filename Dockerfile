FROM golang:1.10.0-alpine

RUN apk update && apk add git
RUN go get -u github.com/drone/drone-ui/dist && \
    go get -u golang.org/x/net/context && \
    go get -u golang.org/x/net/context/ctxhttp && \
    go get -u github.com/golang/protobuf/proto && \
    go get -u github.com/golang/protobuf/protoc-gen-go && \
    cd $GOPATH/src/github.com/drone/ && \
    git clone https://github.com/drone/drone.git && \
    cd drone && git checkout v0.8.6 && \
    go install github.com/drone/drone/cmd/drone-agent

ENTRYPOINT ["/bin/bash"]

FROM docker:dind
COPY --from=0 /go/bin/drone-agent /bin/drone-agent
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
