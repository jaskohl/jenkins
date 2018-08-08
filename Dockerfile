FROM jenkins/jenkins

# NOTE: if we want to install via apt-get switch to root first
USER root

# NOTE: update first
RUN apt-get update 

# NOTE: install packages
RUN apt-get install -y sudo 
RUN apt-get install -y apt-utils 

# NOTE: needed for selenium testing
RUN apt-get install -y python3
RUN apt-get install -y python3-pip 
RUN apt-get install -y xvfb 

# NOTE: requirements for chrome
RUN apt-get install -y fonts-liberation
RUN apt-get install -y libappindicator3-1
RUN apt-get install -y libxss1
RUN apt-get install -y lsb-release
RUN apt-get install -y xdg-utils

# NOTE: add jenkins user to sudoers without requiring a password
# NOTE: can run sudo in shell 
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# NOTE: to allow this container to access /run/docker.sock in the host
# Also ran chmod 777 on host /run/docker.sock first so that might have been what worked also
RUN groupadd -g 993 docker
RUN usermod -aG docker jenkins

# NOTE: drop back to the jenkins user - good practice
USER jenkins
