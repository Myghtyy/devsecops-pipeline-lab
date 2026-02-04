FROM node:14.21.3-bullseye AS builder
WORKDIR /app
COPY package.json ./
RUN npm install 
FROM node:14.21.3-bullseye-slim

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .

RUN groupadd -r sneh && useradd -r -g sneh sneh
USER sneh

EXPOSE 3000
CMD ["node", "index.js"]
