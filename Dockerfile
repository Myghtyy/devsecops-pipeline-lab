FROM node:14.17.0 AS builder
WORKDIR /app
COPY package.json ./
RUN npm install 

FROM ubuntu:18.04
RUN apt-get update && apt-get install -y nodejs
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .

EXPOSE 3000
CMD ["node", "index.js"]
