FROM ubuntu:16.04
RUN mkdir /etc/site
WORKDIR /etc/site
COPY ./pages .
RUN apt update	&& \
	apt install -yf \
	stunnel && \
	mv /etc/site /etc/stunnel
# COPY ./pages .
# EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
