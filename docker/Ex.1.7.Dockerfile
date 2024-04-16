FROM ubuntu:20.04

WORKDIR /usr/src/app

RUN apt update
RUN apt install -y curl

COPY scripts/Ex.1.7.script.sh script.sh

RUN chmod +x script.sh

CMD [ "./script.sh" ]