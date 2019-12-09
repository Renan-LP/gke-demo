FROM ubuntu:16.04
RUN mkdir /etc/site
WORKDIR /etc/site
COPY ./pages .
RUN apt update	&& \
	apt install -yf \
	nginx && \
	mv rouge /var/www/html && \
	mv index.html /var/www/html
# COPY ./pages .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
