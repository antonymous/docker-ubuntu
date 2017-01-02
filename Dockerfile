FROM ubuntu:trusty

# Localization
RUN echo "Europe/Moscow" | tee /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata
RUN sed -i s_//archive.ubuntu.com_//mirror.yandex.ru_ /etc/apt/sources.list

# Installation
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    curl \
    less \
    netcat \
    python-software-properties \
    software-properties-common \
    sudo \
    vim

# Cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# User management
RUN useradd -m -u 1000 dummy \
    && echo "dummy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/dummy \
    && chmod 0440 /etc/sudoers.d/dummy
USER dummy
WORKDIR /home/dummy
