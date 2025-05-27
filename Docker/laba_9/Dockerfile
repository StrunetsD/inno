FROM ubuntu:22.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx && \
    useradd -r nginx

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /etc/nginx/

VOLUME [ "/var/lib/nginx" ]

ENTRYPOINT ["nginx"]  

CMD ["-g", "daemon off;"]