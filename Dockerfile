FROM rockylinux:9 as build

ARG SANDBOX=sandbox_server_1.0.1.zip

RUN yum -y install unzip

COPY ${SANDBOX} /tmp/mod.zip

RUN mkdir /mods \
    && unzip -o -d /mods /tmp/mod.zip \
    && chown -R 1000:1000 /mods

FROM bf2/server:latest

EXPOSE 80/tcp
EXPOSE 4711/tcp
EXPOSE 1500-4999/udp
EXPOSE 1024-1124/udp
EXPOSE 1024-1124/tcp
EXPOSE 16567/udp
EXPOSE 18000/udp
EXPOSE 18000/tcp
EXPOSE 18300/udp
EXPOSE 18300/tcp
EXPOSE 27900/udp
EXPOSE 27900/tcp
EXPOSE 27901/udp
EXPOSE 29900/udp
EXPOSE 29900/tcp
EXPOSE 55123-55125/udp

ENV BF2_MODPATH=mods/sandbox

COPY --from=build /mods /bf2/mods/
