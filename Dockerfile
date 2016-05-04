FROM alpine:latest

# Openshift labels
# https://docs.openshift.com/enterprise/3.1/creating_images/metadata.html

LABEL io.openshift.tags tcplog,socat \
      io.k8s.description This Image receives tcp messages on port 8514 \
      io.openshift.expose-services 8514/tcp


RUN set -x \
    && apk add --no-cache --update \
    socat \
    && rm -rf /var/cache/apk/*

EXPOSE 8514/tcp
USER default

ENTRYPOINT ["/usr/sbin/socat"]
CMD ["tcp4-listen:8514,fork","-"]
