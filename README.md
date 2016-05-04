# Syslog docker image

Due to the fact that some server (squid,...) was not designed for docker or paas I decided to create a small (~5 MB) image which receives tcp messages and write it out to stdout.

This image is based on [Alpine Linux][ac11addb] and [socat][022939b2]

  [ac11addb]: https://www.alpinelinux.org/ "Alpine Linux"
  [022939b2]: http://www.dest-unreach.org/socat/ "socat"

## docker steps

git clone https://github.com/git001/socat-tcp-listen.git  
cd socat-tcp-listen  
docker build --rm -t mysocat .  
docker run -it --rm --net host mysocat  

## openshift

oc new-project tcplogger  
oc new-app https://github.com/git001/socat-tcp-listen.git  

To be able to use this service you will need to add this to your project.

This is the shell output of a example pods

``` oc rsh alpine-socklog-1-kpf5b sh```

```
/ $ env|sort
ALPINE_SOCKLOG_PORT=udp://172.30.104.73:8514
ALPINE_SOCKLOG_PORT_8514_UDP=udp://172.30.104.73:8514
ALPINE_SOCKLOG_PORT_8514_UDP_ADDR=172.30.104.73
ALPINE_SOCKLOG_PORT_8514_UDP_PORT=8514
ALPINE_SOCKLOG_PORT_8514_UDP_PROTO=udp
ALPINE_SOCKLOG_SERVICE_HOST=172.30.104.73
ALPINE_SOCKLOG_SERVICE_PORT=8514
ALPINE_SOCKLOG_SERVICE_PORT_8514_UDP=8514
HOME=/
HOSTNAME=alpine-socklog-1-kpf5b
KUBERNETES_PORT=tcp://172.30.0.1:443
KUBERNETES_PORT_443_TCP=tcp://172.30.0.1:443
KUBERNETES_PORT_443_TCP_ADDR=172.30.0.1
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_53_TCP=tcp://172.30.0.1:53
KUBERNETES_PORT_53_TCP_ADDR=172.30.0.1
KUBERNETES_PORT_53_TCP_PORT=53
KUBERNETES_PORT_53_TCP_PROTO=tcp
KUBERNETES_PORT_53_UDP=udp://172.30.0.1:53
KUBERNETES_PORT_53_UDP_ADDR=172.30.0.1
KUBERNETES_PORT_53_UDP_PORT=53
KUBERNETES_PORT_53_UDP_PROTO=udp
KUBERNETES_SERVICE_HOST=172.30.0.1
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_DNS=53
KUBERNETES_SERVICE_PORT_DNS_TCP=53
KUBERNETES_SERVICE_PORT_HTTPS=443
OPENSHIFT_BUILD_COMMIT=93527d557f9cb52310ca709e4baff9dcd76580f7
OPENSHIFT_BUILD_NAME=alpine-socklog-1
OPENSHIFT_BUILD_NAMESPACE=syslogger
OPENSHIFT_BUILD_SOURCE=https://github.com/git001/alpine-socklog.git
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PWD=/
SHLVL=1
/$
```
