# DOC:
#  - https://pptr.dev/troubleshooting
#  - https://wwebjs.dev/guide/installation.html#installation-on-linux
#  - https://github.com/puppeteer/puppeteer/issues/7740#issuecomment-1875162960
#  - https://github.com/puppeteer/puppeteer/blob/main/docker/Dockerfile

### STAGE 1: Build ###
FROM node:20.18-slim AS build
USER node
WORKDIR /opt/backend
COPY --chown=node:node ./package*.json ./
RUN npm install --package-lock-only
RUN npm ci
COPY --chown=node:node . .
RUN npm run build

### STAGE 2: Run ###
FROM node:20.18-slim

# Configure default locale (important for chrome-headless-shell).
ENV LANG en_US.UTF-8

ENV NODE_ENV production

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --assume-yes --no-install-recommends \
      bash \
      procps \
      curl \
      wget \
      ca-certificates \
      unzip \
      dumb-init \
      fonts-ipafont-gothic \
      fonts-wqy-zenhei \
      fonts-thai-tlwg \
      fonts-kacst \
      fonts-khmeros \
      fonts-freefont-ttf \
      fonts-liberation \
      gconf-service \
      libgbm-dev \
      libasound2 \
      libatk1.0-0 \
      libc6 \
      libcairo2 \
      libcups2 \
      libdbus-1-3 \
      libexpat1 \
      libfontconfig1 \
      libgcc1 \
      libgconf-2-4 \
      libgdk-pixbuf2.0-0 \
      libglib2.0-0 \
      libgtk-3-0 \
      libnspr4 \
      libpango-1.0-0 \
      libpangocairo-1.0-0 \
      libstdc++6 \
      libx11-6 \
      libx11-xcb1 \
      libxcb1 \
      libxcomposite1 \
      libxcursor1 \
      libxdamage1 \
      libxext6 \
      libxfixes3 \
      libxi6 \
      libxrandr2 \
      libxrender1 \
      libxss1 \
      libxtst6 \
      libappindicator1 \
      libnss3 \
      lsb-release \
      xdg-utils \
      dbus \
      dbus-x11 && \
    ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo America/Sao_Paulo > /etc/timezone && \
    # Remove cache of unnecessary packages, documentations and man pages.
    rm -rf /var/lib/apt/lists/* /var/cache/debconf/*-old /usr/share/doc /usr/share/man && \
    # Clear apt cache
    apt-get clean

RUN mkdir -p /opt/backend/dist && chown -R node:node /opt/backend

WORKDIR /opt/backend/dist

USER node

ENV DBUS_SESSION_BUS_ADDRESS autolaunch:

COPY --chown=node:node ./package*.json ./

RUN npm install --package-lock-only
RUN npm ci --omit=dev

COPY --from=build --chown=node:node /opt/backend/dist .

RUN [ -e ../public ] || install -o node -g node -m 770 -d ../public

RUN [ -e .wwebjs_auth ] || install -o node -g node -m 770 -d .wwebjs_auth

RUN [ -e .wwebjs_cache ] || install -o node -g node -m 770 -d .wwebjs_cache

CMD ["dumb-init", "node", "server.js"]