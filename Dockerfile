FROM ubuntu:12.10
MAINTAINER Frank Macreery <frank@macreery.com>

RUN apt-get update
RUN apt-get install -y build-essential libssl-dev openssh-client man-db

ADD . openssh
RUN adduser --quiet --system --no-create-home --home /var/run/sshd \
		--shell /usr/sbin/nologin sshd
RUN cd openssh && ./configure && make && make install

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
