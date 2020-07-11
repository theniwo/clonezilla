#FROM debian:latest
#FROM theniwo/gobuntu:latest
FROM ubuntu:latest

ARG BUILD_DATE
ARG NAME
ARG VCS_REF
ARG VERSION

LABEL maintainer="disp@mailbox.org"
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$NAME \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/theniwo/clonezilla" \
      org.label-schema.version=$VERSION

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install bc clonezilla dialog dosfstools openssh-server parted procps squashfs-tools
RUN apt-get -y clean
RUN apt-get -y autoclean
RUN apt-get -y autoremove


# Set up users and passwords
RUN echo 'root:toor' | chpasswd

# Set up ssh process
RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Set Variables
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Copy the file from your host to your current location. (This has to be done as the last step before running CMD or ENTRYPOINT)
COPY ./content /

# Inform Docker that the container is listening on the specified port at runtime.
EXPOSE 22

# Run on startup
ENTRYPOINT \
  /usr/sbin/sshd -D

#RUN echo "Initial logfile" >> /var/log/clonezilla.log
# forward request and error logs to docker log collector
#RUN ln -sf /dev/stdout /var/log/clonezilla.log \
# && ln -sf /dev/stderr /var/log/clonezilla.log
#CMD ["/usr/bin/tail", "-f", "/var/log/clonezilla.log"]
