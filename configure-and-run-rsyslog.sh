#!/bin/bash

if [ $PAPERTRAIL_PORT ]; then
  EXTRA_CONFIG="
\$ModLoad imudp
\$UDPServerRun 514

\$DefaultNetstreamDriverCAFile /etc/syslog.papertrail.crt # trust these CAs
\$ActionSendStreamDriver gtls # use gtls netstream driver
\$ActionSendStreamDriverMode 1 # require TLS
\$ActionSendStreamDriverAuthMode x509/name # authenticate by hostname

\$ActionResumeInterval 10
\$ActionQueueSize 100000
\$ActionQueueDiscardMark 97500
\$ActionQueueHighWaterMark 80000
\$ActionQueueType LinkedList
\$ActionQueueFileName papertrailqueue
\$ActionQueueCheckpointInterval 100
\$ActionQueueMaxDiskSpace 2g
\$ActionResumeRetryCount -1
\$ActionQueueSaveOnShutdown on
\$ActionQueueTimeoutEnqueue 10
\$ActionQueueDiscardSeverity 0

*.*            @@logs.papertrailapp.com:$PAPERTRAIL_PORT"

  echo "$EXTRA_CONFIG" >> /etc/rsyslog.conf

  rsyslogd -n
else
  echo "You must configure PAPERTRAIL_PORT"
  exit 1
fi
