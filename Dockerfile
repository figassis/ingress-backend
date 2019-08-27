FROM figassis/ubuntu-golang:latest

ARG BACKEND=/go/src/github.com/kubernetes
RUN mkdir -p $BACKEND
ADD . $BACKEND/app
RUN go get -u github.com/kardianos/govendor && go install github.com/kardianos/govendor
RUN cd $BACKEND/app && govendor init && govendor add +e && govendor sync && govendor fetch +m && go build -o /backend && mv rootfs/www /

WORKDIR /
EXPOSE 8080
CMD ["/backend"]