# TCPlog docker image

Due to the fact that some server (squid,...) was not designed for docker or paas I decided to create a small (~5 MB) image which receives tcp messages and write it out to stdout.

This image is based on [Alpine Linux][ac11addb] and [socat][022939b2]

  [ac11addb]: https://www.alpinelinux.org/ "Alpine Linux"
  [022939b2]: http://www.dest-unreach.org/socat/ "socat"
  
When you behind a proxy you need to add the env variable to the builds

## docker steps

git clone https://github.com/git001/socat-tcp-listen.git  
cd socat-tcp-listen  
docker build --rm -t mysocat .  
docker run -it --rm --net host mysocat  

## openshift

oc new-project tcplogger  
oc new-app https://github.com/git001/socat-tcp-listen.git --name='tcplogger'  

To be able to use this service you will need to add this to your project.

This is the shell output of a squid pods

```
oc logs -f tcplogger-7-xq14p |awk '{print strftime("%Y-%m-%d %H:%M:%S ",$1) $0}'
2016-05-04 12:31:30 1462357890.571     18 10.1.3.1 TCP_MISS/302 800 GET http://google.com/ - FIRSTUP_PARENT/<IP> text/html
2016-05-04 12:31:30 1462357890.609     37 10.1.3.1 TCP_MISS/200 12518 GET http://www.google.com.sg/? - FIRSTUP_PARENT/<IP> text/html
2016-05-04 12:32:11 1462357931.063      4 10.1.3.1 TCP_MISS/302 800 GET http://google.com/ - FIRSTUP_PARENT/<IP> text/html
2016-05-04 12:32:11 1462357931.092     28 10.1.3.1 TCP_MISS/200 12486 GET http://www.google.com.sg/? - FIRSTUP_PARENT/<IP> text/html
2016-05-04 12:58:33 1462359513.104    151 10.1.3.1 TCP_MISS/200 4672 CONNECT google.com:443 - FIRSTUP_PARENT/<IP> -
2016-05-04 12:58:33 1462359513.104     47 10.1.3.1 TCP_MISS/200 23215 CONNECT www.google.com.sg:443 - FIRSTUP_PARENT/<IP> -
```
