FROM million12/varnish

RUN yum install -y perl-Redis perl-LWP-Protocol-http10 \
	&& yum clean all

COPY build/varnish/conf/varnish.vcl /varnish/data/varnish.vcl
