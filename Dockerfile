FROM quay.io/aptible/ubuntu:12.10
MAINTAINER Frank Macreery <frank@macreery.com>

ADD . /tmp/openssh

# Create privilege separation user and build patched OpenSSH from source
RUN adduser --quiet --system --no-create-home --home /var/run/sshd \
    --shell /usr/sbin/nologin sshd && \
    apt-get install -y build-essential libssl-dev man-db && \
    cd /tmp/openssh && ./configure --prefix=/usr --sysconfdir=/etc/ssh && \
    make && make install && cd .. && rm -rf openssh

ADD templates /etc/ssh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
