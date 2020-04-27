FROM ubuntu as builder

RUN apt-get update \
    && apt-get install -y \
      cvs \
      make \
      gcc \
      zlib1g \
      zlib1g-dev \
      openssl \
      libssl-dev \
      libmbedtls-dev \
      wget
    
WORKDIR /root
RUN cvs -d :pserver:cvs@cvs.fefe.de:/cvs -z9 co dietlibc \
    && cvs -d :pserver:cvs@cvs.fefe.de:/cvs -z9 co libowfat \
    && cvs -d :pserver:cvs@cvs.fefe.de:/cvs -z9 co tinyldap

WORKDIR /root/dietlibc
RUN make && make install

WORKDIR /root/libowfat
RUN make && make install

WORKDIR /root/tinyldap
RUN make && make install

RUN wget -O /root/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_x86_64 && chmod 0555 /root/dumb-init

FROM alpine
COPY --from=builder /opt/diet/bin/ /opt/
COPY --from=builder /root/dumb-init /opt/dumb-init

ENTRYPOINT ["/opt/dumb-init", "--"]
CMD ["/opt/tinyldap"]
