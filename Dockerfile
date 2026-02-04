FROM node:14.17.0 AS builder
WORKDIR /app
COPY package.json ./
RUN npm install 

FROM centos:7
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
    yum install -y nodejs
    
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .

# Still follow best practices so we don't get 'Misconfiguration' hits
RUN groupadd -r sneh && useradd -r -g sneh sneh
USER sneh

EXPOSE 3000
CMD ["node", "index.js"]
