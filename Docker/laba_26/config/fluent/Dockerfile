FROM fluent/fluentd:v1.16-1

USER root

RUN apk add --no-cache --update --virtual .build-deps \
        build-base ruby-dev \
 && apk add --no-cache bash \ 
 && fluent-gem install fluent-plugin-elasticsearch \
 && fluent-gem install fluent-plugin-http-healthcheck \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

RUN rm -f /fluentd/etc/fluent.conf

COPY fluent.conf /fluentd/etc/
ENV FLUENTD_CONF="fluent.conf"

USER fluent