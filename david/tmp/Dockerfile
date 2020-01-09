FROM ubuntu:16.04
RUN mkdir /etc/site
WORKDIR /etc/site
COPY ./pages .
RUN apt-get update &&\
	apt-get install -yf stunnel &&\
	mv /etc/site /etc/stunnel &&\
CMD ["nginx", "-g", "daemon off;"]
