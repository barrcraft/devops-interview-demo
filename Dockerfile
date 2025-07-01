ARG SERVICE_NAME="devops-interview-demo"

# Compile and build the app
FROM node:22-slim AS builder
ARG SERVICE_NAME
ENV SERVICE_NAME="$SERVICE_NAME"
COPY package.json ./
COPY package-lock.json ./
COPY public ./public
COPY src ./src
RUN NPM_CONFIG_USERCONFIG=".npmrc" npm install --immutable --immutable-cache --check-cache
RUN npm run build 
RUN npm run test:unit:ci

# Final image exposed to container orchestration platform
FROM nginx:1.29-alpine
ARG SERVICE_NAME
ENV SERVICE_NAME="$SERVICE_NAME"
COPY --from=builder /build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
