FROM openjdk:8

WORKDIR /usr/src/app

# Only clones spring project
RUN git clone --single-branch --depth 1 --sparse https://github.com/docker-hy/material-applications
WORKDIR /usr/src/app/material-applications
RUN git sparse-checkout init --cone
RUN git sparse-checkout set spring-example-project
WORKDIR /usr/src/app/material-applications/spring-example-project

RUN ./mvnw package

EXPOSE 8080

CMD [ "java", "-jar", "./target/docker-example-1.1.3.jar" ]