FROM alpine:latest

RUN apk update
RUN apk add busybox-extras
RUN apk add postfix dovecot mailutils

COPY postfix/* /etc/postfix/
COPY dovecot.conf /etc/dovecot/
COPY users /etc/dovecot/
RUN chown root:dovecot /etc/dovecot/users
RUN chmod 640 /etc/dovecot/users

RUN adduser -D umair
RUN echo "umair:test" | chpasswd

RUN postfix start

ENTRYPOINT ["dovecot"]
CMD ["-F"]
