FROM ubuntu:16.04
RUN apt update	&& \
	apt install -yf stunnel
CMD ["nginx", "-g", "daemon off;"]
