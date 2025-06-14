FROM jenkins/jenkins:lts-jdk11

# NOTE: if we want to install via apt-get switch to root first
USER root

# NOTE: update, install packages, and clean up in one layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    apt-utils \
    python3 \
    python3-pip \
    xvfb \
    fonts-liberation \
    libappindicator3-1 \
    libxss1 \
    lsb-release \
    xdg-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# NOTE: add jenkins user to sudoers without requiring a password
# NOTE: can run sudo in shell 
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# NOTE: to allow this container to access /run/docker.sock in the host
# Also ran chmod 777 on host /run/docker.sock first so that might have been what worked also
RUN groupadd -g 993 docker
RUN usermod -aG docker jenkins

# NOTE: drop back to the jenkins user - good practice
USER jenkins
