# Use the official Ubuntu stable LTS as base
FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install all required host packages for Yocto Scarthgap 5.0
RUN apt-get update && apt-get install -y \
    gawk wget git diffstat unzip texinfo gcc build-essential \
    chrpath socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 \
    python3-subunit zstd liblz4-tool file locales ca-certificates \
    lz4 rsync git-lfs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up the correct locale (Yocto requires UTF-8)
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Yocto strictly forbids building as root. Create a dedicated 'yocto' user.
RUN useradd -ms /bin/bash yocto
USER yocto
WORKDIR /home/yocto

# Default entry point
CMD ["/bin/bash"]
