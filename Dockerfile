FROM golang:1.13
WORKDIR /go/src/github.com/pacedotdev/
RUN git clone https://github.com/thavlik/oto.git
WORKDIR /go/src/github.com/pacedotdev/oto
RUN go get -u ./...
RUN go install
ENV templates=$GOPATH/src/github.com/pacedotdev/oto/otohttp/templates
CMD ["oto"]
