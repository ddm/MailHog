FROM alpine

RUN apk --no-cache add --virtual build-dependencies \
    go \
    git \
    musl-dev \
  && mkdir -p /tmp/go \
  && GOPATH=/tmp/go go get github.com/mailhog/MailHog \
  && mv /tmp/go/bin/MailHog /usr/local/bin/mailhog \
  && rm -rf /tmp/go \
  && apk del --purge build-dependencies \
  && adduser -D -u 1000 mailhog

EXPOSE 1025 8025
USER mailhog
WORKDIR /tmp
ENTRYPOINT ["mailhog"]
