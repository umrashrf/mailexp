FROM alpine:latest

RUN apk update
RUN apk add busybox-extras vim
RUN apk add postfix dovecot mailutils

COPY postfix/* /etc/postfix/
COPY dovecot.conf /etc/dovecot/
COPY users /etc/dovecot/
RUN chown root:dovecot /etc/dovecot/users
RUN chmod 640 /etc/dovecot/users

RUN adduser -D umair mail
RUN mkdir -p /home/umair/Maildir/cur && \
    mkdir -p /home/umair/Maildir/new && \
    mkdir -p /home/umair/Maildir/tmp
RUN chown umair:umair -R /home/umair/Maildir
RUN echo "umair:test" | chpasswd

RUN awk '{gsub(/smtp\t+25/, "smtp\t\t36245"); print}' /etc/services > /tmp/services
RUN cp /tmp/services /etc/ && rm /tmp/services

RUN newaliases && postfix start

ENTRYPOINT ["dovecot"]
CMD ["-F"]
