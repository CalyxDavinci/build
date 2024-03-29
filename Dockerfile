FROM registry.fedoraproject.org/fedora-minimal:36

RUN microdnf install -y \
             git \
             bison \
             which \
             ccache \
             perl \
             patchutils \
             automake \
             autoconf \
             binutils \
             flex \
             gcc \
             gcc-c++ \
             gdb \
             glibc-devel \
             libtool \
             pkgconf \
             pkgconf-m4 \
             pkgconf-pkg-config \
             strace \
             bzip2 \
             python3 \
             make \
             openssl \
             openssl-devel \
             curl \
             procps-ng \
             openssh-clients \
             freetype \
             freetype-devel \
             rsync \
             xz \
             tar \
             ncurses-compat-libs

RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo && chmod +x /usr/bin/repo

COPY entrypoint.sh /

CMD ["/usr/bin/bash", "entrypoint.sh"]
