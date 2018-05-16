FROM alpine:3.7
MAINTAINER BenchX <labs@benchx.io>

RUN apk update && \
    apk upgrade && \
    apk --no-cache add curl jq file

VOLUME [ /benchchain-test ]
WORKDIR /benchchain-test
EXPOSE 6610 6611 6612 6613
ENTRYPOINT ["/usr/bin/benchchain-test.sh"]
CMD ["node", "--proxy_app", "benchd"]
STOPSIGNAL SIGTERM

COPY benchcore.sh /usr/bin/benchchain-test.sh
