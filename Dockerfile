FROM node:22-alpine AS builder
WORKDIR /app
COPY package.json ./
RUN npm install --package-lock=false --omit=dev

FROM alpine:3.21
RUN apk add --no-cache nodejs
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .

EXPOSE 3000

RUN addgroup -S sneh && adduser -S sneh -G sneh
USER sneh

CMD ["node", "index.js"]
