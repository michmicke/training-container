FROM node:22-alpine AS builder

WORKDIR /srv
ENV PATH="$PATH:/srv/node_modules/.bin"
COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build && \
    prisma generate

FROM node:22-alpine

RUN apk --update --no-cache add \
    tini=~0.19.0

WORKDIR /srv
ENV PATH="$PATH:/srv/node_modules/.bin"
COPY package.json package-lock.json ./
COPY --from=builder /srv/prisma /srv/prisma
RUN npm install --omit=dev

COPY --from=builder /srv/dist /srv/dist
COPY --from=builder /srv/node_modules /srv/node_modules

EXPOSE 9393
# For explanation to tini see
# - https://nodeshift.dev/nodejs-reference-architecture/development/building-good-containers#use-a-process-manager
# - https://github.com/krallin/tini
ENTRYPOINT ["/sbin/tini", "--"]
CMD [ "node", "dist/main.js" ]
