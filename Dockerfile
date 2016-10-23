FROM debian:jessie
MAINTAINER Jean-Avit Promis "docker@katagena.com"

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install keepass2 wget libmono-system-xml-linq4.0-cil libmono-system-data-datasetextensions4.0-cil libmono-system-runtime-serialization4.0-cil mono-mcs && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://raw.github.com/pfn/keepasshttp/master/KeePassHttp.plgx
RUN chmod 644 KeePassHttp.plgx
RUN mv KeePassHttp.plgx /usr/lib/keepass2/

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/user && \
    echo "user:x:${uid}:${gid}:User,,,:/home/user:/bin/bash" >> /etc/passwd && \
    echo "user:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/user

USER user
ENV HOME /home/user

CMD /usr/bin/keepass2
