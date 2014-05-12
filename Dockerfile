FROM democracyworks/base
MAINTAINER Democracy Works, Inc. <dev@turbovote.org>

RUN apt-get install -q -y rsyslog
RUN apt-get install -q -y rsyslog-gnutls

ADD syslog.papertrail.crt /etc/syslog.papertrail.crt
ADD configure-and-run-rsyslog.sh /configure-and-run-rsyslog.sh
ADD supervisord-rsyslog.conf /etc/supervisor/conf.d/supervisord-rsyslog.conf
RUN echo "*.=notice;*.=warn |/dev/console" > /etc/rsyslog.d/50-default.conf

EXPOSE 514/udp

CMD ["/run.sh"]
