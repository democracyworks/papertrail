FROM quay.io/democracyworks/base
MAINTAINER Democracy Works, Inc. <dev@turbovote.org>

RUN apt-get install -q -y rsyslog
RUN apt-get install -q -y rsyslog-gnutls

ADD syslog.papertrail.crt /etc/syslog.papertrail.crt
ADD configure-and-run-rsyslog.sh /configure-and-run-rsyslog.sh
RUN echo "*.=notice;*.=warn |/dev/console" > /etc/rsyslog.d/50-default.conf

EXPOSE 514/udp

CMD ["/configure-and-run-rsyslog.sh"]
