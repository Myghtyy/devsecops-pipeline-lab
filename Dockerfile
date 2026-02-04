# Stage 1: Build the app
FROM node:14.17.0 AS builder
WORKDIR /app
COPY package.json ./
RUN npm install 

# Stage 2: Final Image - Ubuntu 20.04 (Standard Support)
FROM ubuntu:20.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js 14 and basic tools
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .

# Security Best Practice: Run as non-root
RUN groupadd -r sneh && useradd -r -g sneh sneh
USER sneh

EXPOSE 3000
CMD ["node", "index.js"]
