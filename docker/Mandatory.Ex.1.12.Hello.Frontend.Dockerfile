FROM ubuntu:latest

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y curl && apt-get install -y git
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash
RUN apt install -y nodejs

# Only clones the frontend project
RUN git clone --single-branch --depth 1 --sparse https://github.com/docker-hy/material-applications
WORKDIR /usr/src/app/material-applications
RUN git sparse-checkout init --cone
RUN git sparse-checkout set example-frontend
WORKDIR /usr/src/app/material-applications/example-frontend

RUN npm install
RUN npm run build
RUN npm install -g serve

EXPOSE 5000

CMD ["npx", "serve", "-s", "-l", "5000", "build"]