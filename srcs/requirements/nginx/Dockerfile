FROM debian:buster

RUN apt-get update && apt-get install -y \
    nginx \
    openssl

# Create certif TLS
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/nginx.crt -keyout /etc/nginx/ssl/nginx.key -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=42/CN=lcalvie/emailAddress=lcalvie@student.42.fr"

# Conf file nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# port
EXPOSE 443 9998

ENTRYPOINT ["nginx", "-g", "daemon off;"]

