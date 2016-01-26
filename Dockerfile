FROM mhart/alpine-node:5

# Workaround: https://github.com/npm/npm/issues/9863
RUN npm install -g npm --prefix=/usr/local
RUN ln -s -f /usr/local/bin/npm /usr/bin/npm

RUN apk add --update curl \
    && curl -Ls https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz \
           | tar xz -C /

ENV RASTERIZER_PHANTOMJS /usr/local/bin/phantomjs
ENV RASTERIZER_PORT 3001
ENV RASTERIZER_HOST 127.0.0.1
ENV RASTERIZER_PATH /tmp
ENV RASTERIZER_VIEWPORT 1024x600
ENV CACHE_LIFETIME 60000
ENV SERVER_PORT 3000
ENV SERVER_HOST 127.0.0.1
ENV SERVER_USECORS true

EXPOSE 3000

WORKDIR /app
ADD . /app

RUN ["npm", "install", "--production"]
RUN ["node", "app", "--production"]
