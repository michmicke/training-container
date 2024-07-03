FROM node:22-alpine AS builder

WORKDIR /app
COPY package.json package-lock.json /app/
RUN npm install

ARG VITE_API_BASE_URL
COPY . .
RUN npm run build

FROM docker.io/nginx:1.27
COPY nginx.conf /etc/nginx/conf.d/
COPY --from=builder /app/dist /usr/share/nginx/html

