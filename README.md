## devopswithdocker

[DevOps with Docker](https://devopswithdocker.com/) provides an introduction to container technologies, with a particular focus on Docker and container orchestration using Docker Compose.

This course consists of three parts, with exercises in each part. In this article, I have my notes on Docker and the solutions I came up with for each exercise.

## Solutions
* [Part I](#part1)
  * [Definitions and basic concepts](#part1-1)
    * [Exercise 1.1 - 1.2](#ex-1-1-2)
  * [Running and stopping containers](#part1-2)
    * [Exercise 1.3](#ex-1-3)
    * [Exercise 1.4](#ex-1-4)
  * [In-depth dive to images](#part1-3)
    * [Exercise 1.5 - 1.6](#ex-1-5-6)
    * [Exercise 1.7 - 1.8](#ex-1-7-8)
  * [Defining start conditions for the container](#part1-4)
  * [Interacting with the container via volumes and ports](#part1-5)
    * [Exercise 1.9](#ex-1-9)
    * [Exercise 1.10](#ex-1-10)
  * [Utilizing tools from the Registry](#part1-6)
    * [Exercise 1.11 - 1.14](#ex-1-11-14)
    * [Exercise 1.15 - 1.16](#ex-1-15-16)
* [Part II](#part2)
  * [Migrating to Docker Compose](#part2-1)
    * [Exercise 2.1](#ex-2-1)
    * [Exercise 2.2 - 2.3](#ex-2-2-3)
  * [Docker networking](#part2-2)
    * [Exercise 2.4](#ex-2-4)
    * [Exercise 2.5](#ex-2-5)
  * [Volumes in action](#part2-3)
    * [Exercise 2.6 - 2.10](#ex-2-6-10)
  * [Containers in development](#part2-4)
    * [Exercise 2.11](#ex-2-11)
* [Part III](#part3)
  * [Official Images and trust](#part3-1)
  * [Deployment pipelines](#part3-2)
    * [Exercises 3.1 - 3.4](#ex-3-1-4)
  * [Using a non-root user](#part3-3)
    * [Exercise 3.5](#ex-3-5)
  * [Optimizing the image size](#part3-4)
    * [Exercise 3.6](#ex-3-6)
    * [Exercise 3.7](#ex-3-7)
    * [Exercises 3.8 - 3.10](#ex-3-8-10)
  * [Multi-host environments](#part3-5)
    * [Exercise 3.11](#ex-3-11)

---

## PART I <a name="part1"></a>

### Definitions and basic concepts <a name="part1-1"></a>
- **Exercise 1.1: Getting Started - Exercise 1.2: Cleanup** [#](https://devopswithdocker.com/part-1/section-1#exercises-11-12) <a name="ex-1-1-2"></a>

Start 3 containers from an image that does not automatically exit (such as nginx) in detached mode.
```sh
$ docker run -d --name container1 nginx
$ docker run -d --name container2 nginx
$ docker run -d --name container3 nginx
```
Stop two of the containers and leave one container running.
```sh
$ docker stop container1
$ docker stop container2
```
Show 2 stopped containers and one running.
```sh
$ docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS                      PORTS     NAMES
7dcd774ee17d   nginx     "/docker-entrypoint.…"   18 seconds ago   Up 17 seconds               80/tcp    container3
7e646b62ac5c   nginx     "/docker-entrypoint.…"   22 seconds ago   Exited (0) 8 seconds ago              container2
ca23e85b6b10   nginx     "/docker-entrypoint.…"   25 seconds ago   Exited (0) 10 seconds ago             container1
```

Clean the Docker daemon by removing all images and containers.
```sh
$ docker stop container3
$ docker container prune -f
Deleted Containers:
7dcd774ee17d36f2cd17cf0816adad185938fdf8d3dbf061ca32f5bb97c0f7f7
7e646b62ac5c9a463e8f4a749a29980ef986a81f7b46913aadc4b41e85533346
ca23e85b6b10b88356885ad95d03db88e2120adf4b53dd1c5a2de54c6b56cd2c
$ docker rmi nginx
Untagged: nginx:latest
Untagged: nginx@sha256:84c52dfd55c467e12ef85cad6a252c0990564f03c4850799bf41dd738738691f
Deleted: sha256:b690f5f0a2d535cee5e08631aa508fef339c43bb91d5b1f7d77a1a05cea021a8
Deleted: sha256:2599673318db03e2df10bca9b4167be668b9579d72c3cedd1436a0ddcbc4686f
Deleted: sha256:3dfa00af383371dcbb76086fde405df32b75247bdf6db81110d992284140c5a3
Deleted: sha256:22b6d0744dd5a77166622ec69cc6520f63c9df0dd65b9c96934658c3684aef14
Deleted: sha256:da1a2f0bf2f9a1e0eaf448084f492dfe868dc0a64ca3e0e30f3b9be6ded452f0
Deleted: sha256:9cf4de78149512efb3285ea0da170ebcd38cdca48d5eb90030400663db6facfb
Deleted: sha256:61901066ba33b727b13c970b9d7b7ed9a3056e30de96e835c9b01f4e73c4659a
Deleted: sha256:fb1bd2fc52827db4ce719cc1aafd4a035d68bc71183b3bc39014f23e9e5fa256
```

---

### Running and stopping containers <a name="part1-2"></a>
- **Exercise 1.3: Secret Message** [#](https://devopswithdocker.com/part-1/section-2#exercise-13) <a name="ex-1-3"></a>

Image `devopsdockeruh/simple-web-service:ubuntu` will start a container that outputs logs into a file. Go inside the container and use `tail -f ./text.log` to follow the logs. Every 10 seconds the clock will send you a "secret message".

Submit the secret message and command(s) given as your answer.
```sh
$ docker run -d --name logger devopsdockeruh/simple-web-service:ubuntu
$ docker exec -it logger bash
root@7c5676383d05:/usr/src/app# tail -f ./text.log
Secret message is: 'You can find the source code here: https://github.com/docker-hy'
2024-02-08 08:50:05 +0000 UTC
2024-02-08 08:50:07 +0000 UTC
2024-02-08 08:50:09 +0000 UTC
2024-02-08 08:50:11 +0000 UTC
2024-02-08 08:50:13 +0000 UTC
Secret message is: 'You can find the source code here: https://github.com/docker-hy'
2024-02-08 08:50:15 +0000 UTC
2024-02-08 08:50:17 +0000 UTC
^C
```

- **Exercise 1.4: Missing Dependencies** [#](https://devopswithdocker.com/part-1/section-2#exercise-14) <a name="ex-1-4"></a>

Start a Ubuntu image with the process `sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'`

```sh
$ docker run -d -it --name curler ubuntu sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'
$ docker attach curler
helsinki.fi
Searching..
sh: 1: curl: not found
Input website:
read escape sequence
$ docker exec -it curler /bin/bash -c "apt update && apt install -y curl"
$ docker attach curler
helsinki.fi
Searching..
<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx/1.22.1</center>
</body>
</html>
Input website:
^C
```
Note:<br>
`$ docker attach looper`<br>
*hit control+p, control+q to detach us from the STDOUT*<br>

`$ docker attach --no-stdin looper`<br>
*hit control+c to detach us from the STDOUT*<br>

---

### In-depth dive to images <a name="part1-3"></a>
- **Exercise 1.5: Sizes of Images - Exercise 1.6: Hello Docker Hub** [#](https://devopswithdocker.com/part-1/section-3#exercises-15---16) <a name="ex-1-5-6"></a>

In the Exercise 1.3 we used devopsdockeruh/simple-web-service:ubuntu.

Here is the same application but instead of Ubuntu is using Alpine Linux: devopsdockeruh/simple-web-service:alpine.

Pull both images and compare the image sizes. Go inside the alpine container and make sure the secret message functionality is the same. Alpine version doesn't have bash but it has sh.

```sh
$ docker run -d -it --name logger devopsdockeruh/simple-web-service:alpine
$ docker exec -it logger sh -c 'tail -f ./text.log'
2024-02-08 10:55:01 +0000 UTC
Secret message is: 'You can find the source code here: https://github.com/docker-hy'
2024-02-08 10:55:03 +0000 UTC
2024-02-08 10:55:05 +0000 UTC
2024-02-08 10:55:07 +0000 UTC
2024-02-08 10:55:09 +0000 UTC
2024-02-08 10:55:11 +0000 UTC
Secret message is: 'You can find the source code here: https://github.com/docker-hy'
2024-02-08 10:55:13 +0000 UTC
^C
$ docker images
REPOSITORY                          TAG       IMAGE ID       CREATED       SIZE
ubuntu                              latest    fd1d8f58e8ae   13 days ago   77.9MB
devopsdockeruh/simple-web-service   ubuntu    4e3362e907d5   2 years ago   83MB
devopsdockeruh/simple-web-service   alpine    fd312adc88e0   2 years ago   15.7MB
```

Run `docker run -it devopsdockeruh/pull_exercise`.

It will wait for your input. Navigate through Docker hub to find the docs and Dockerfile that was used to create the image.

Read the Dockerfile and/or docs to learn what input will get the application to answer a "secret message".

Submit the secret message and command(s) given to get it as your answer.

```sh
$ docker run -it devopsdockeruh/pull_exercise
Unable to find image 'devopsdockeruh/pull_exercise:latest' locally
latest: Pulling from devopsdockeruh/pull_exercise
8e402f1a9c57: Pull complete
5e2195587d10: Pull complete
6f595b2fc66d: Pull complete
165f32bf4e94: Pull complete
67c4f504c224: Pull complete
Digest: sha256:7c0635934049afb9ca0481fb6a58b16100f990a0d62c8665b9cfb5c9ada8a99f
Status: Downloaded newer image for devopsdockeruh/pull_exercise:latest
Give me the password: basics
You found the correct password. Secret message is:
"This is the secret message"
```

- **Exercise 1.7: Image for Script - Exercise 1.8: Two Line Dockerfile** [#](https://devopswithdocker.com/part-1/section-3#exercises-17---18) <a name="ex-1-7-8"></a>

Create a Dockerfile for a new image that starts from ubuntu:20.04 and add instructions to install curl into that image. Then add instructions to copy the script file into that image and finally set it to run on container start using CMD.

**docker/Ex.1.7.Dockerfile**
```dockerfile
FROM ubuntu:20.04

WORKDIR /usr/src/app

RUN apt update
RUN apt install -y curl

COPY scripts/Ex.1.7.script.sh script.sh

RUN chmod +x script.sh

CMD [ "./script.sh" ]
```

```sh
$ docker build . -t curler -f docker/Ex.1.7.Dockerfile
$ docker run -it curler
Input website:
helsinki.fi
Searching..
<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx/1.22.1</center>
</body>
</html>
```

Try docker run `devopsdockeruh/simple-web-service:alpine hello`. The application reads the argument "hello" but will inform that hello isn't accepted.

In this exercise create a Dockerfile and use FROM and CMD to create a brand new image that automatically runs server.

```
$ docker run devopsdockeruh/simple-web-service:alpine hello


The application accepts 1 argument "server". Use the argument server to run the server

If no arguments are supplied the application will output log strings to a file.


Arguments given: hello
```
**docker/Ex.1.8.Dockerfile**
```dockerfile
FROM devopsdockeruh/simple-web-service:alpine

CMD [ "server" ]
```
```sh
$ docker build . -t web-server -f docker/Ex.1.8.Dockerfile
$ docker run web-server
[GIN-debug] [WARNING] Creating an Engine instance with the Logger and Recovery middleware already attached.

[GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
 - using env:   export GIN_MODE=release
 - using code:  gin.SetMode(gin.ReleaseMode)

[GIN-debug] GET    /*path                    --> server.Start.func1 (3 handlers)
[GIN-debug] Listening and serving HTTP on :8080
```

---

### Defining start conditions for the container <a name="part1-4"></a>

---

### Interacting with the container via volumes and ports <a name="part1-5"></a>
- **Exercise 1.9: Volumes** [#](https://devopswithdocker.com/part-1/section-5#exercise-19) <a name="ex-1-9"></a>

Image `devopsdockeruh/simple-web-service` creates a timestamp every two seconds to `/usr/src/app/text.log` when it's not given a command. Start the container with bind mount so that the logs are created into your filesystem.

```
$ docker run -v "$(pwd)/logs/Ex.1.9.text.log:/usr/src/app/text.log" devopsdockeruh/simple-web-service
Starting log output
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
Wrote text to /usr/src/app/text.log
^C
```

- **Exercise 1.10: Ports Open** [#](https://devopswithdocker.com/part-1/section-5#exercise-110) <a name="ex-1-10"></a>

The image `devopsdockeruh/simple-web-service` will start a web service in port `8080` when given the argument "server". In Exercise 1.8 you already did a image that can be used to run the web service without any argument.

Use now the -p flag to access the contents with your browser. The output to your browser should be something like: `{ message: "You connected to the following path: ...`

```sh
$ docker build . -t web-server -f docker/Ex.1.8.Dockerfile
$ docker run -p 127.0.0.1:3456:8080 web-server
[GIN-debug] [WARNING] Creating an Engine instance with the Logger and Recovery middleware already attached.

[GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
 - using env:   export GIN_MODE=release
 - using code:  gin.SetMode(gin.ReleaseMode)

[GIN-debug] GET    /*path                    --> server.Start.func1 (3 handlers)
[GIN-debug] Listening and serving HTTP on :8080
[GIN] 2024/02/08 - 16:35:46 | 200 |        34.3µs |      172.17.0.1 | GET      "/"
[GIN] 2024/02/08 - 16:35:46 | 200 |          29µs |      172.17.0.1 | GET      "/favicon.ico"
```
![image](https://github.com/akinbezatoglu/s3ync/assets/61403011/ee91b197-e2f8-4f3f-9728-90667f01828a)

---

### Utilizing tools from the Registry <a name="part1-6"></a>
- **Exercise 1.11 - 1.14** [#](https://devopswithdocker.com/part-1/section-6#exercises-111-114) <a name="ex-1-11-14"></a>

Create a Dockerfile for an old Java Spring project that can be found from the [course repository](https://github.com/docker-hy/material-applications/tree/main/spring-example-project).

The setup should be straightforward with the README instructions. Tips to get you started:

Use [openjdk](https://hub.docker.com/_/openjdk) image `FROM openjdk:_tag_` to get Java instead of installing it manually. Pick the tag by using the README and Docker Hub page.

**docker/Ex.1.11.Dockerfile**
```dockerfile
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
```

```sh
$ docker build . -t spring-server -f docker/Ex.1.11.Dockerfile
$ docker run -p 127.0.0.1:3456:8080 spring-server

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.3.RELEASE)

2024-02-08 17:24:18.873  INFO 1 --- [           main] c.d.dockerexample.DemoApplication        : Starting DemoApplication v1.1.3 on fa9f5f7aff2e with PID 1 (/usr/src/app/material-applications/spring-example-project/target/docker-example-1.1.3.jar started by root in /usr/src/app/material-applications/spring-example-project)
2024-02-08 17:24:18.876  INFO 1 --- [           main] c.d.dockerexample.DemoApplication        : No active profile set, falling back to default profiles: default
2024-02-08 17:24:20.563  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2024-02-08 17:24:20.608  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2024-02-08 17:24:20.608  INFO 1 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.16]
2024-02-08 17:24:20.628  INFO 1 --- [           main] o.a.catalina.core.AprLifecycleListener   : The APR based Apache Tomcat Native library which allows optimal performance in production environments was not found on the java.library.path: [/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib]
2024-02-08 17:24:20.740  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2024-02-08 17:24:20.741  INFO 1 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 1778 ms
2024-02-08 17:24:21.080  INFO 1 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2024-02-08 17:24:21.332  INFO 1 --- [           main] o.s.b.a.w.s.WelcomePageHandlerMapping    : Adding welcome page template: index
2024-02-08 17:24:21.620  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2024-02-08 17:24:21.625  INFO 1 --- [           main] c.d.dockerexample.DemoApplication        : Started DemoApplication in 3.289 seconds (JVM running for 3.834)
2024-02-08 17:24:30.247  INFO 1 --- [nio-8080-exec-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServlet'
2024-02-08 17:24:30.248  INFO 1 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
2024-02-08 17:24:30.276  INFO 1 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : Completed initialization in 28 ms
2024-02-08 17:25:12.571  INFO 1 --- [       Thread-3] o.s.s.concurrent.ThreadPoolTaskExecutor  : Shutting down ExecutorService 'applicationTaskExecutor'
```
![image](https://github.com/akinbezatoglu/s3ync/assets/61403011/14d82be4-dd45-4743-8ccb-810e21197818)

**MANDATORY PROJECT**

Clone, fork or download the project from https://github.com/docker-hy/material-applications/tree/main/example-frontend.

Create a Dockerfile for the project (example-frontend) and give a command so that the project runs in a Docker container with port 5000 exposed and published so when you start the container and navigate to http://localhost:5000 you will see message if you're successful.

**docker/Mandatory.Ex.1.12.Hello.Frontend.Dockerfile**
```dockerfile
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
```

```sh
$ docker build . -t example-frontend -f docker/Mandatory.Ex.1.12.Hello.Frontend.Dockerfile
$ docker run -p 5000:5000 example-frontend
 INFO  Accepting connections at http://localhost:5000
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 GET /
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 Returned 200 in 98 ms
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 GET /static/js/2.43ca3586.chunk.js
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 GET /static/css/main.eaa5d75e.chunk.css
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 Returned 200 in 16 ms
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 GET /static/js/main.5871e2ac.chunk.js
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 Returned 200 in 21 ms
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 Returned 200 in 73 ms
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 GET /static/media/toskalogo.c0f35cf0.svg
 HTTP  2/8/2024 7:29:49 PM 172.17.0.1 Returned 200 in 17 ms
 HTTP  2/8/2024 7:29:50 PM 172.17.0.1 GET /favicon.ico
 HTTP  2/8/2024 7:29:50 PM 172.17.0.1 Returned 200 in 3 ms
 HTTP  2/8/2024 7:29:50 PM 172.17.0.1 GET /manifest.json
 HTTP  2/8/2024 7:29:50 PM 172.17.0.1 Returned 200 in 5 ms
 HTTP  2/8/2024 7:29:58 PM 172.17.0.1 GET /api/ping
 HTTP  2/8/2024 7:29:58 PM 172.17.0.1 Returned 200 in 9 ms
```
![image](https://github.com/akinbezatoglu/s3ync/assets/61403011/8f24c19e-b6da-41ec-936b-6beee3d3f72a)

**docker/Mandatory.Ex.1.13.Hello.Backend.Dockerfile**
```dockerfile
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
```

```sh
$ docker build . -t example-backend -f docker/Mandatory.Ex.1.13.Hello.Backend.Dockerfile
$ docker run -p 5000:8080 example-backend
[Ex 2.4+] REDIS_HOST env was not passed so redis connection is not initialized
[Ex 2.6+] POSTGRES_HOST env was not passed so postgres connection is not initialized
[GIN-debug] [WARNING] Creating an Engine instance with the Logger and Recovery middleware already attached.

[GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
 - using env:   export GIN_MODE=release
 - using code:  gin.SetMode(gin.ReleaseMode)

[GIN-debug] GET    /ping                     --> server/router.pingpong (4 handlers)
[GIN-debug] GET    /messages                 --> server/controller.GetMessages (4 handlers)
[GIN-debug] POST   /messages                 --> server/controller.CreateMessage (4 handlers)
[GIN-debug] Listening and serving HTTP on :8080
[GIN] 2024/02/08 - 19:51:34 | 404 |    1.862146ms |      172.17.0.1 | GET      "/"
[GIN] 2024/02/08 - 19:51:34 | 404 |      11.998µs |      172.17.0.1 | GET      "/favicon.ico"
[GIN] 2024/02/08 - 19:51:42 | 200 |     377.303µs |      172.17.0.1 | GET      "/ping"
```
![image](https://github.com/akinbezatoglu/s3ync/assets/61403011/515f5997-0b16-45db-9bc2-5976b932c2b3)

- **Exercise 1.15 - 1.16** [#](https://devopswithdocker.com/part-1/section-6#exercises-115-116) <a name="ex-1-15-16"></a>
```sh
$ docker login
Authenticating with existing credentials...
Login Succeeded
$ docker build . -t golang-app -f golang-app/Dockerfile
$ docker tag golang-app <username>/getting-started
$ docker push <username>/getting-started:latest
The push refers to repository [docker.io/<username>/getting-started]
7d1218aed597: Pushed
62e0059ba7ef: Pushed
latest: digest: sha256:117b11b6ffa32e4785771291d6226cc214bf45d875bf09ad40c07ee6dfaa72e1 size: 734
```
#### Google Cloud Run
Container Image URL: docker.io/username/getting-started:latest

![Screenshot 2024-04-16 234307](https://github.com/akinbezatoglu/devopswithdocker/assets/61403011/56bcb04a-979b-4d19-904e-fffbdf2ff107)

![Screenshot 2024-04-16 233803](https://github.com/akinbezatoglu/devopswithdocker/assets/61403011/bff650af-b118-4eb3-8871-83a62788b8fb)

---

## PART II <a name="part2"></a>

### Migrating to Docker Compose <a name="part2-1"></a>
- **Exercise 2.1** [#](https://devopswithdocker.com/part-2/section-1#exercise-21) <a name="ex-2-1"></a>
- **Exercise 2.2 - 2.3** [#](https://devopswithdocker.com/part-2/section-1#exercises-22---23) <a name="ex-2-2-3"></a>

### Docker networking <a name="part2-2"></a>
- **Exercise 2.4** [#](https://devopswithdocker.com/part-2/section-2#exercise-24) <a name="ex-2-4"></a>
- **Exercise 2.5** [#](https://devopswithdocker.com/part-2/section-2#exercises-25) <a name="ex-2-5"></a>

### Volumes in action <a name="part2-3"></a>
- **Exercise 2.6 - 2.10** [#](https://devopswithdocker.com/part-2/section-3#exercises-26---210) <a name="ex-2-6-10"></a>

### Containers in development <a name="part2-4"></a>
- **Exercise 2.11** [#](https://devopswithdocker.com/part-2/section-4#exercise-211) <a name="ex-2-11"></a>

## PART III <a name="part3"></a>

### Official Images and trust <a name="part3-1"></a>

### Deployment pipelines <a name="part3-2"></a>
- **Exercise 3.1 - 3.4** [#](https://devopswithdocker.com/part-3/section-2#exercises-31-34) <a name="ex-3-1-4"></a>

### Using a non-root user <a name="part3-3"></a>
- **Exercise 3.5** [#](https://devopswithdocker.com/part-3/section-3#exercise-35) <a name="ex-3-5"></a>

### Optimizing the image size <a name="part3-4"></a>
- **Exercise 3.6** [#](https://devopswithdocker.com/part-3/section-4#exercise-36) <a name="ex-3-6"></a>
- **Exercise 3.7** [#](https://devopswithdocker.com/part-3/section-4#exercise-37) <a name="ex-3-7"></a>
- **Exercise 3.8 - 3.10** [#](https://devopswithdocker.com/part-3/section-4#exercises-38---310) <a name="ex-3-8-10"></a>

### Multi-host environments <a name="part3-5"></a>
- **Exercise 3.11** [#](https://devopswithdocker.com/part-3/section-5#exercise-311) <a name="ex-3-11"></a>
