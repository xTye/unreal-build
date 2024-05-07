# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to non-interactive (to avoid timezone prompt issue)
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  python3 \
  python3-pip \
  git \
  curl \
  gnupg \
  lsb-release \
  software-properties-common

# Install Perforce Helix Command-Line Client (P4)
RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - \
  && echo "deb http://package.perforce.com/apt/ubuntu $(lsb_release -sc) release" | tee /etc/apt/sources.list.d/perforce.list \
  && apt-get update \
  && apt-get install -y helix-cli

# Install Unreal Engine dependencies
RUN apt-get install -y \
  build-essential \
  clang-10 \
  libssl-dev

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up your Unreal Engine installer script or download it directly (needs to be hosted externally or added via ADD command)
# ADD setup-unreal-engine.sh /usr/local/bin/setup-unreal-engine.sh
# RUN /usr/local/bin/setup-unreal-engine.sh

# Set the working directory
WORKDIR /project

# Copy build script and entrypoint
COPY build-and-deploy.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/build-and-deploy.sh

ENTRYPOINT ["/usr/local/bin/build-and-deploy.sh"]
