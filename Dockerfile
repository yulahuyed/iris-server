FROM alpine:3.3

RUN apk add --update-cache bash vim curl ca-certificates \
  && rm -rf /var/cache/apk/*

# ENV CADDY_VERSION 0.8.3
ENV CADDY_FEATURES ""
  #^ "cors,git,hugo,ipfilter,jsonp,search"

RUN curl -fsSL "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=off" \
    | tar -xz -C /usr/bin \
  && chmod u+x /usr/bin/caddy

COPY ./Caddyfile /etc/caddy/

RUN echo "SUCCESS" > /home/index.html
RUN chmod 777 /home/index.html /etc/caddy/Caddyfile

EXPOSE 80
CMD ["/usr/bin/caddy", "-conf", "/etc/caddy/Caddyfile"]
