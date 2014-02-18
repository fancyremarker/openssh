FROM quay.io/aptible/ubuntu:12.10
MAINTAINER Frank Macreery <frank@macreery.com>

RUN apt-get install -y build-essential libssl-dev man-db

ADD . /tmp/openssh
RUN adduser --quiet --system --no-create-home --home /var/run/sshd \
		--shell /usr/sbin/nologin sshd
RUN cd /tmp/openssh && ./configure --prefix=/usr --sysconfdir=/etc/ssh && \
		make && make install

ADD templates/ssh_config /etc/ssh/ssh_config
ADD templates/sshd_config /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
