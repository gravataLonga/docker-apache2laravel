FROM ubuntu:xenial

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Change sources to a server in Portugal to make package download faster
RUN sed -i 's/http:\/\//http:\/\/pt./g' /etc/apt/sources.list

# Install Apache
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade
RUN apt-get -y install apache2

# Enable Apache Modules
RUN a2enmod rewrite proxy_fcgi expires headers

COPY conf /
RUN chmod +x /usr/local/bin/httpd-foreground
# RUN chmod +x /usr/local/bin/httpd-foreground

RUN useradd application
WORKDIR /var/www

EXPOSE 80
ENTRYPOINT ["httpd-foreground"]
