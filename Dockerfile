# Menggunakan Ubuntu sebagai base image (kompatibilitas tinggi)
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Mencegah interaksi saat instalasi
ENV DEBIAN_FRONTEND=noninteractive

# Set locale agar tampilan terminal benar (UTF-8)
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Update dan install tmate serta openssh-client
RUN apt-get update && apt-get install -y \
    tmate \
    openssh-client \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /

CMD ["tmate", "-F", "-S", "/bin/bash"]
