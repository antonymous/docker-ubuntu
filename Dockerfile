FROM ubuntu

RUN sed -i s_//archive.ubuntu.com_//mirror.yandex.ru_ /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    curl \
    less \
    netcat \
    python-software-properties \
    software-properties-common \
    vim

# Cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m -u 1000 dummy
RUN echo "dummy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/dummy
RUN chmod 0440 /etc/sudoers.d/dummy

USER dummy
WORKDIR /home/dummy
