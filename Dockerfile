FROM php:7-alpine

RUN apk update && \
    apk add graphviz ttf-dejavu && \
    rm -rf \
        /var/cache/apk/* \
        /tmp/*

COPY bin/    /dcv/bin
COPY src/    /dcv/src
COPY vendor/ /dcv/vendor

RUN addgroup dcv && \
    adduser -D -G dcv -s /bin/bash -g "docker-compose-viz" -h /input dcv

USER dcv
VOLUME /input
WORKDIR /input

ENTRYPOINT ["/dcv/bin/dcv"]
CMD ["render", "-m", "image", "-f"]