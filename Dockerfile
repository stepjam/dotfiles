FROM ubuntu:20.04
MAINTAINER Stephen James

ENV DEBIAN_FRONTEND=noninteractive

# OS updates and install
RUN apt-get -qq update
RUN TZ=Etc/UTC apt-get -y install tzdata  # stop tzdata asking for timezone
RUN apt-get install git sudo build-essential curl -qq -y

# Create test user and add to sudoers
RUN useradd -m -s /bin/bash tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/tester/dotfiles
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME /home/tester

# Change working directory
WORKDIR /home/tester/dotfiles

# Run setup
RUN make all

CMD ["/bin/fish"]
