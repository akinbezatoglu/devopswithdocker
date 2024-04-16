FROM golang:1.16

WORKDIR /usr/src/app

# RUN apt-get update && apt-get install -y git

# Only clones the backend project
RUN git clone --single-branch --depth 1 --sparse https://github.com/docker-hy/material-applications
WORKDIR /usr/src/app/material-applications
RUN git sparse-checkout init --cone
RUN git sparse-checkout set example-backend
WORKDIR /usr/src/app/material-applications/example-backend

RUN go build .

EXPOSE 8080

CMD ["./server"]