FROM arm64v8/debian:bookworm

RUN echo 'deb-src http://deb.debian.org/debian bookworm main' >> /etc/apt/sources.list
RUN echo 'deb-src http://deb.debian.org/debian-security bookworm-security main' >> /etc/apt/sources.list
RUN echo 'deb-src http://deb.debian.org/debian bookworm-updates main' >> /etc/apt/sources.list
RUN apt update

RUN apt -y upgrade
RUN apt -y install vim-nox git

RUN apt -y build-dep mutter

RUN mkdir /root/mutter
COPY *.patch /root/mutter/
COPY patches_very_experimental/*.patch /root/mutter/
COPY compile.sh /root/mutter/

# WORKDIR /root/mutter
# CMD /root/mutter/compile.sh

ENTRYPOINT /root/mutter/compile.sh
