FROM ubuntu:12.04
MAINTAINER TurboVote <dev@turbovote.org>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update -q
RUN apt-get install -q -y rsyslog
RUN apt-get install -q -y rsyslog-gnutls

ADD syslog.papertrail.crt /etc/syslog.papertrail.crt
ADD configure-and-run-rsyslog.sh /configure-and-run-rsyslog.sh

EXPOSE 514/udp

CMD ["/configure-and-run-rsyslog.sh"]
