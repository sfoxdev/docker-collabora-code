FROM ubuntu:16.04
MAINTAINER SFoxDev <admin@sfoxdev.com>

ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="C.UTF-8" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8"

RUN apt-get update && apt-get -y upgrade ; \
    apt-get -y install apt-transport-https locales-all hyphen-* mc ; \
    echo "deb https://collaboraoffice.com/repos/CollaboraOnline/CODE /" >> /etc/apt/sources.list.d/collabora.list ; \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6CCEA47B2281732DF5D504D00C54D189F4BA284D ; \
    apt-get update ; \
    apt-get -y install loolwsd code-brand ;

ADD start.sh /start.sh

EXPOSE 9980

CMD /start.sh
