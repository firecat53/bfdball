### Install latest hugo and build the project
FROM alpine

RUN apk --no-cache add ca-certificates curl && \
    tag=$(curl -sX GET "https://api.github.com/repos/gohugoio/hugo/releases/latest" \
        | awk '/tag_name/{print $4;exit}' FS='[""]') && \
    curl -o \
        /tmp/hugo.tar.gz -L \
        https://github.com/gohugoio/hugo/releases/download/$tag/hugo_${tag/v}_Linux-64bit.tar.gz && \
    tar xf /tmp/hugo.tar.gz -C /tmp/ && \
    mv /tmp/hugo /usr/local/bin/hugo

COPY . /data
WORKDIR /data
ENV HUGO_ENV production
RUN hugo

### Build nginx container

FROM nginx:alpine
LABEL "Maintainer"="Scott Hansen <firecat4153@gmail.com>"

COPY --from=0 /data/public /usr/share/nginx/html
