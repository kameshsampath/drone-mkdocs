#syntax=docker/dockerfile:1.3-labs

FROM alpine
ARG TARGETARCH

LABEL org.opencontainers.image.source https://github.com/kameshsampath/drone-mkdocs-site
LABEL org.opencontainers.image.authors="Kamesh Sampath<kamesh.sampath@hotmail.com>"

LABEL description="A Drone plugin to build mkdocs site"

RUN apk -Uuv add curl bash  ca-certificates \
    && apk update \
    && apk add python3 py3-pip \
    && pip3 install -U mkdocs mkdocs-material mike \
    && mkdir -p /build

ADD site.sh /bin/
RUN chmod +x /bin/site.sh

WORKDIR /build

CMD ["/bin/site.sh"]