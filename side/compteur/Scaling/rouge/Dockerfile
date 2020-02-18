FROM ubuntu:16.04
RUN mkdir /etc/site
WORKDIR /etc/site
COPY ./pages .
RUN pip install locustio
#	mv bleu /var/www/html && \
#	mv index.html /var/www/html
# COPY ./pages .
EXPOSE 8089 5557 5558
CMD ["nginx", "-g", "daemon off;"]
